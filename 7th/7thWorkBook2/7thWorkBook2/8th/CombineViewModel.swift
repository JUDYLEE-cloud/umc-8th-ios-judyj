//
//  CombineViewModel.swift
//  7thWorkBook2
//
//  Created by 이주현 on 6/23/25.
//

import Foundation
import Combine
import CombineMoya
import Moya

class CombineViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    // Moya를 이용한 네트워크 요청을 담당하는 객체
    private let provider: MoyaProvider<UserRotuer>
    
    @Published var userName: String = ""
    @Published var isLoading: Bool = false
    @Published var userData: UserData? = nil // 네트워크로 받아온 사용자 정보를 저장
    
    init(provider: MoyaProvider<UserRotuer> = APIManager.shared.createProvider(for: UserRouter.self)) {
        // provider를 초기화
        self.provider = provider
        
        $userName
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { name in
                self.getUser(name: name)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$userData) // 결과를 userData에 자동 저장
    }
    
    // AnyPublisher<Output, Failure>
    // Output 어떤 값을 내보낼지, Failure 어떤 타입의 에러를 내보낼지
    // Failture에 Never을 썼다는 것은, 이 Publisher은 에러를 절대 내보내지 않는다는 뜻. 후에 catch 수정자에서 Just(nil)로 처리해서 가능함
    private func getUser(name: String) => AnyPublisher<UserData?, Never> {
        // 이름으로 사용자 정보를 요청하는 네트워크 요청 Publisher를 만듦
        provider.requestPublisher(.getPerson(name: name))
            .handleEvents(
                receiveSubscription: { _ in
                    DispatchQueue.main.async {
                        self.isLoading = true
                    }
                },
                receiveCompletion: { _ in
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            )
            .map(\.data)
            .decode(type: UserData.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .catch { error -> Just<UserData?> in
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                }
                return Just(nil)
            }
            .eraseToAnyPublisher() // 반환 타입을 AnyPublisher로 감싸서 외부에서 내부 구현을 신경 쓰지 않고 쓸 수 있게 함
    }
}

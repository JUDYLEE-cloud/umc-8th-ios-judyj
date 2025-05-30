import Foundation
import Moya

@Observable
// MoyaProvider: API 요청을 보내는 함수 정의
class ContentViewModel {
    var userData: UserData?
    let provider: MoyaProvider<UserRouter>
    
    init() {
        // NetworkLoggerPlugin은 Moya에서 기본으로 제공하는, 로그를 출력하는 플로그인.
        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        // .verbose: 로그 전체 출력
        self.provider = MoyaProvider<UserRouter>(plugins: [logger])
    }
    
    // POST: 서버에 새로운 유저 추가
    func createUser(_ userData: UserData) {
        provider.request(.postPerson(userData: userData)) { result in
            switch result {
                case .success(let response): print("POST 성공: \(response.statusCode)")
                case .failure(let error): print("error", error)
            }
        }
    }
    
    // GET: 서버에 있는 유저 데이터를 가져옴
    func getUserData(name: String) {
        provider.request(.getPerson(name: name), completion: {[weak self] result in
            switch result {
            case .success(let response):
                do {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: response.data)
                    self?.userData = decodedData
                } catch {
                    print("❌ 유저 데이터 디코드 오류", error)
                }
            case .failure(let error): print("❌ error", error)
            }
        })
    }
    
    // PATCH: 유저의 일부 데이터 수정
    func updateUserPatch(_ patchData: UserPatchReqeust) {
        provider.request(.patchPerson(patchData: patchData)) { result in
            switch result {
            case .success(let response): print("PATCH 성공: \(response.statusCode)")
            case .failure(let error): print("error", error)
            }
        }
    }
    
    // PUT: 유저의 전체 데이터 수정
    func updateUserPut(_ userData: UserData) {
        provider.request(.putPerson(userData: userData)) { result in
            switch result {
            case .success(let response): print("PUT 성공: \(response.statusCode)")
            case .failure(let error): print("error", error)
            }
        }
    }
    
    // DELETE: 유저 데이터 삭제
    func deleteUser(name: String) {
        provider.request(.deletePerson(name: name)) { result in
            switch result {
            case .success(let response): print("DELETE 성공: \(response.statusCode)")
            case .failure(let error): print("error", error)
            }
        }
    }
}

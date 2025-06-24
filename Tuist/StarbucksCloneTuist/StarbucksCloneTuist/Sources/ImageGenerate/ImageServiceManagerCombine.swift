//
//  ImageServiceManagerCombine.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/24/25.
//

import Foundation
import UIKit
import CombineMoya
import Combine
import Moya

enum ImageAPI {
    case generate(prompt: String, negativePrompt: String)
    case getProgress
}

extension ImageAPI: TargetType {
    // 1. 공통 주소
    var baseURL: URL{ URL(string: Config.imageURL)!}
    
    // 2. api 세부 경루
    var path: String {
        switch self {
        case .generate: return "/sdapi/v1/txt2img"
        case .getProgress: return "/sdapi/v1/progress"
        }
    }
    
    // 3. http method
    var method: Moya.Method {
        switch self {
        case .generate: return .post
        case .getProgress: return .get
        }
    }
    
    // 4. 보낼 데이터
    var task: Task {
        switch self {
        case let .generate(prompt, negativePrompt):
            let parameters = [
                "prompt": prompt,
                "negative_prompt": negativePrompt
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .getProgress: return .requestPlain
        }
    }
    
    // 5. 헤더 설정
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    // 6. 샘플 데이터 - 현재는 필요 없음
    var sampleData: Data {Data()}
}

class CombineViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    // 커스텀 타임아웃 세션
    let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30000 // 요청 타임아웃 (초)
        configuration.timeoutIntervalForResource = 30000 // 리소스 전체 수신 타임아웃
        
        return Session(configuration: configuration)
    }()
    
    private let provider: MoyaProvider<ImageAPI>
    
    //    init(provider: MoyaProvider<ImageAPI> = APIManager.shared.createProvider(for: ImageAPI.self)) {
    //        self.provider = provider
    //    }
    init() {
        self.provider = MoyaProvider<ImageAPI>(
            session: session,
            plugins: [NetworkLoggerPlugin()]
        )
    }
    
    func generateImage(prompt: String, negativePrompt: String) -> AnyPublisher<UIImage, Error> {
        provider.requestPublisher(.generate(prompt: prompt, negativePrompt: negativePrompt))
            .map(\.data)
            .decode(type: Txt2ImgImageOnlyResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .tryMap { response in
                guard let base64 = response.images.first,
                      let data = Data(base64Encoded: base64),
                      let image = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                return image
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getProgress() -> AnyPublisher<Double, Never> {
        provider.requestPublisher(.getProgress)
            .map(\.data)
            .decode(type: ProgressResponse.self, decoder: JSONDecoder())
            .map { $0.progress }
            .replaceError(with: 0.0)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

//final class ImageServiceManager {
//    static let shared = ImageServiceManager()
//
//    private init() {}
//
//    private let baseURL = "\(Config.imageURL)"
//
//    // 커스텀 타임아웃 세션
//    private let session: Session = {
//        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = 30000 // 요청 타임아웃 (초)
//        configuration.timeoutIntervalForResource = 30000 // 리소스 전체 수신 타임아웃
//
//        return Session(configuration: configuration)
//    }()
//
//    func generateImage(prompt: String, negativePrompt: String) async throws -> UIImage? {
//        let generateURL =  "\(baseURL)/sdapi/v1/txt2img"
//        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
//
//        let dataTask = session.request(
//            generateURL,
//            method: .post,
//            parameters: request,
//            encoder: JSONParameterEncoder.default
//        )
//        .validate()
//        .serializingDecodable(Txt2ImgImageOnlyResponse.self)
//
//        let result = try await dataTask.value
//
//        guard let base64 = result.images.first,
//              let data = Data(base64Encoded: base64),
//              let image = UIImage(data: data) else {
//            print("이미지 디코딩 실패")
//            return nil
//        }
//
//        return image
//    }
//    
//    func getProgress() async throws -> ProgressResponse {
//        let progressURL = "\(baseURL)/sdapi/v1/progress"
//
//        let dataTask = session.request(
//            progressURL,
//            method: .get
//        )
//            .validate()
//            .serializingDecodable(ProgressResponse.self)
//
//        return try await dataTask.value
//    }
//}

import Foundation
import Alamofire
import UIKit

final class ImageServiceManager {
    static let shared = ImageServiceManager()
    
    private init() {}
    
    private let baseURL = "\(Config.imageURL)/sdapi/v1/txt2img"
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30000 // 요청 타임아웃 (300초)
        configuration.timeoutIntervalForResource = 30000 // 리소스 전체 수신 타임아웃
        return Session(configuration: configuration)
    }()
    
    func generateImage(prompt: String, negativePrompt: String) async throws -> UIImage? {
        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
        
        let dataTask = session.request(
            baseURL,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(Txt2ImgImageOnlyResponse.self)
        
        let result = try await dataTask.value
        
        guard let base64 = result.images.first,
              let data = Data(base64Encoded: base64),
              let image = UIImage(data: data) else {
            print("이미지 디코딩 실패")
            return nil
        }
        return image
    }
    
}

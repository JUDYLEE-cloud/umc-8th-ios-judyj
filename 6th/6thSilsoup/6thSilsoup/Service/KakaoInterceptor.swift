import Foundation

// alamofire의 interceptor 사용하여 카카오 인증 키 헤더에 넣기
import Alamofire

class KakaoInterceptor: RequestInterceptor, @unchecked Sendable {
    private let kakaoAPIKey: String
    
    init(apiKey: String) {
        self.kakaoAPIKey = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.authorization("KakaoAK \(kakaoAPIKey)"))
        
        completion(.success(request))
    }
}

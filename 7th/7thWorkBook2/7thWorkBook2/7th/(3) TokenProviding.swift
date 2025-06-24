// 규칙 - 토큰이 필요할 때 가져오고, 만료되면 새로 서버에서 받아오기 - 을 정의한 프로토콜
import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}

import Foundation

// 네트워크 오류를 대비해서 옵셔널로 설정
struct UserInfo: Codable {
    var accessToken: String?
    var refreshToken: String?
}

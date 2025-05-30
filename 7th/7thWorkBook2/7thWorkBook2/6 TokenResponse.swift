import Foundation

struct TokenResponse: Codable {
//    let isSuccess: Bool
//    let code: String
//    let message: String
//    let result: UserInfo
    
    var accessToken: String
    var refreshToken: String
}

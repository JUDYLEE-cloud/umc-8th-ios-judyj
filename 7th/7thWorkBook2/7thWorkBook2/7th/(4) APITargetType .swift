import Foundation
import Moya

protocol APITargetType: TargetType {}

// UserRouter, AuthRouter 같은 api 라우터들이
// 매번 중복 코드를 작성하지 않아도 되게 함
extension APITargetType {
    var baseURL: URL {
        return URL(string: "\(Config.baseURL)")!
    }
    
    // 헤더를 자동으로 붙여줌
    var headers: [String: String]? {
        switch task {
        case .requestJSONEncodable, .requestParameters:
            return ["Content-Type": "application/json"]
        case .uploadMultipart:
            return ["Content-Type": "multipart/form-data"]
        default:
            return nil
        }
    }
    
    // 200~299만 성공으로 간주
    var validationType: ValidationType { .successCodes }
}

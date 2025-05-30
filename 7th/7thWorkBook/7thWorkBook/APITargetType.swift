// 기본 URL 정의
import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {
    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    // headers 추가 정보
    // 중앙 집중 관리형으로 관리할 수 있도록 함
    var headers: [String : String]? {
        switch task {
            case .requestJSONEncodable, .requestParameters: return ["Content-Type": "application/json"]
            case .uploadMultipart: return ["Content-Type": "multipart/form-data"]
            default: return nil
        }
    }
}

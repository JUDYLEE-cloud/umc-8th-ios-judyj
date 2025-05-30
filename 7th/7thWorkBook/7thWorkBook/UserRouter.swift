import Foundation
import Moya

struct UserData: Codable {
    let name: String
    let age: Int
    let address: String
    let height: Double
}

// PATCH는 사람 정보 일부 수정이기 때문에 옵셔널을 따로 만들어야 함
struct UserPatchReqeust: Codable {
    let name: String?
    let age: Int?
    let address: String?
    let height: Double?
}

enum UserRouter {
    // 파라미터를 요구하는 메소드
    case getPerson(name: String)
    case deletePerson(name: String)
    
    // body를 요구하는 메소드.
    // body에 해당하는 모델 데이터를 전달할 수 있어야. 그래서 위에서 UserData, UserPatchRequest 정의한 것임.
    // 이 두개는 Codable 프로토콜을 가져야 함. 
    case postPerson(userData: UserData)
    case patchPerson(patchData: UserPatchReqeust)
    case putPerson(userData: UserData)
}


// APITargetType(기본 URL 정의한 파일)
extension UserRouter: APITargetType {
    
    // path(기본 URL 뒤에 붙는 세부 경로) 작성
    var path: String {
        return "/person"
        // 우리가 쓰는 5개의 메소드는 모두 http://localhost:8080/person이기 때문에 하나로 끝나는 것
    }
    
    // 각 case마다 다른 method(요청 방식) 정의
    var method: Moya.Method {
        switch self {
            case .getPerson: return .get
            case .postPerson: return .post
            case .patchPerson: return .patch
            case .putPerson: return .put
            case .deletePerson: return .delete
        }
    }
    
    // task (어떤 데이터를, 어떻게 보낼지)
    // 우리의 경우 파라미터를 요구하는 메소드(GET, DELETE), body를 요구하는 메소드(POST, PATCH, PUT)로 나뉨
    // body 요구하는 메소드 중 PATCH는 옵셔널 모델이 있으니 따로
    var task: Task {
        switch self {
        case .getPerson(let name), .deletePerson(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.queryString)
            
        case .postPerson(userData: let userData), .putPerson(userData: let userData):
            return .requestJSONEncodable(userData)
        case .patchPerson(let patchData):
            return .requestJSONEncodable(patchData)
        }
    }
}

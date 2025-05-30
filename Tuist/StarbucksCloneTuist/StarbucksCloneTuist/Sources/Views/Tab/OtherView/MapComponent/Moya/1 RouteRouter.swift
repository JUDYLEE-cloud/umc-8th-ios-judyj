import Foundation
import Moya

// 좌표 구조체 정의
struct Coordinate {
    let lon: Double
    let lat: Double
}

enum RouteRouter: TargetType {
    case fetchRoute(start: Coordinate, end: Coordinate)

    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }
    
    var path: String {
        switch self {
        case .fetchRoute(let start, let end):
            return "/route/v1/foot/\(start.lon),\(start.lat);\(end.lon),\(end.lat)"
        }
    }

    var method: Moya.Method { .get }

    var task: Task {
        switch self {
        case .fetchRoute:
            return .requestParameters(
                parameters: [
                    "geometries": "geojson",
                    "overview": "full"
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Sample.route.data(using: .utf8)!
    }
}

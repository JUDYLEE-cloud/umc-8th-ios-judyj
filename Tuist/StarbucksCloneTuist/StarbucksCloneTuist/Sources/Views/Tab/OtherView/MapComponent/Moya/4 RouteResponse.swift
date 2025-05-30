import Foundation

struct RouteResponse: Codable {
    let code: String
    let routes: [Route]
    let waypoints: [Waypoint]

    struct Route: Codable {
        let geometry: Geometry
        let legs: [Leg]
        let weightName: String
        let weight: Double
        let duration: Double
        let distance: Double

        enum CodingKeys: String, CodingKey {
            case geometry, legs
            case weightName = "weight_name"
            case weight, duration, distance
        }
    }

    struct Geometry: Codable {
        let coordinates: [[Double]]
        let type: String
    }

    struct Leg: Codable {
        let steps: [Step]
        let summary: String
        let weight: Double
        let duration: Double
        let distance: Double
    }

    struct Step: Codable {
        // OSRM에서 step은 비워져 있을 수 있으니 optional 처리
        let name: String?
    }

    struct Waypoint: Codable {
        let hint: String
        let distance: Double
        let name: String
        let location: [Double]
    }
}


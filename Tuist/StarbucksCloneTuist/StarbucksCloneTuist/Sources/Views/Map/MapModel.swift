import Foundation
import CoreLocation

struct MapInfoModel: Codable {
    let type: String
    let name: String
    let features: [FeatureModel]
}

struct FeatureModel: Codable, Identifiable {
    var id = UUID()  // For SwiftUI List, ForEach 사용
    let type: String
    let properties: PropertiesModel
    let geometry: GeometryModel

    // CodingKeys로 id 제외
    private enum CodingKeys: String, CodingKey {
        case type
        case properties
        case geometry
    }
}

struct PropertiesModel: Codable {
    let seq: String
    let storeName: String
    let address: String
    let telephone: String
    let category: String
    let yCoordinate: Double
    let xCoordinate: Double

    // JSON key랑 Swift property랑 이름이 다를 때 매핑
    private enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case storeName = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case yCoordinate = "Ycoordinate"
        case xCoordinate = "Xcoordinate"
    }
}

struct GeometryModel: Codable {
    let type: String
    let coordinates: [Double]
}

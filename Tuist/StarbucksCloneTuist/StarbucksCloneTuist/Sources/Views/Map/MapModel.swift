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
    let storeImageName: String?
    let photoReference: String?  // 추가

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
    
    // 후에 json 파일에 이미지 넣으면 삭제
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            seq = try container.decode(String.self, forKey: .seq)
            storeName = try container.decode(String.self, forKey: .storeName)
            address = try container.decode(String.self, forKey: .address)
            telephone = try container.decode(String.self, forKey: .telephone)
            category = try container.decode(String.self, forKey: .category)
            yCoordinate = try container.decode(Double.self, forKey: .yCoordinate)
            xCoordinate = try container.decode(Double.self, forKey: .xCoordinate)
            storeImageName = nil // 디코딩할 게 없으니까 기본값 nil로
            photoReference = nil  // JSON에서 받는 값은 아니므로 nil로 초기화
        }
    
}

struct GeometryModel: Codable {
    let type: String
    let coordinates: [Double]
}

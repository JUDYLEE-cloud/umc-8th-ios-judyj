//
//  FindMapViewModel.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 5/26/25.
//

import Foundation

struct Place: Identifiable, Decodable {
    let id: String
    let place_name: String
    let address_name: String
    
    let x: String?
    let y: String?

    init(id: String = UUID().uuidString, place_name: String, address_name: String, x: String? = nil, y: String? = nil) {
        self.id = id
        self.place_name = place_name
        self.address_name = address_name
        self.x = x
        self.y = y
    }

    // 기존 커스텀 init(from:) 유지
    private enum CodingKeys: String, CodingKey {
        case id
        case place_name
        case address_name
        case x
        case y
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        place_name = try container.decode(String.self, forKey: .place_name)
        address_name = try container.decode(String.self, forKey: .address_name)
        x = try? container.decode(String.self, forKey: .x)
        y = try? container.decode(String.self, forKey: .y)
        if let idString = try? container.decode(String.self, forKey: .id) {
            id = idString
        } else if let idInt = try? container.decode(Int.self, forKey: .id) {
            id = String(idInt)
        } else {
            id = UUID().uuidString
        }
    }
}

struct KakaoPlaceResponse: Decodable {
    let documents: [Place]
}


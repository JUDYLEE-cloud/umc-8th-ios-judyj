//
//  Config.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let imageURL: String = {
        guard let imageURL = Config.infoDictionary["Image_URL"] as? String else {
            fatalError()
        }
        return imageURL
    }()
}

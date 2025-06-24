//
//  CardDataModel.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import Foundation
import SwiftData

@Model
class Card {
    var cardImageName: String
    @Attribute(.unique) var cardTitle: String
    var cardAmount: Int
    @Attribute(.unique) var cardNumber: String
    @Attribute(.unique) var createdAt: Date
    
    init(cardImageName: String, cardTitle: String, cardAmount: Int, cardNumber: String, createdAt: Date) {
        self.cardImageName = cardImageName
        self.cardTitle = cardTitle
        self.cardAmount = cardAmount
        self.cardNumber = cardNumber
        self.createdAt = createdAt
    }
}

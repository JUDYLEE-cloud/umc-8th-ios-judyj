//
//  Card.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 6/23/25.
//

import Foundation

struct Card: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var subtitle: String
    var image: String
}

var Cards: [Card] = [
    .init(title: "Card1", subtitle: "This is Card 1", image: "BasicCard"),
    .init(title: "Card2", subtitle: "This is Card 2", image: "Card2"),
    .init(title: "Card3", subtitle: "This is Card 3", image: "Card3")
]

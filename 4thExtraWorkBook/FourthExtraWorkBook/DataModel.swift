//
//  DataModel.swift
//  FourthExtraWorkBook
//
//  Created by 이주현 on 4/12/25.
//

import Foundation
import SwiftData

@Model
// 데이터베이스로 저장할거라고 선언

class Task {
    @Attribute(.unique) var title: String
    // title은 고유한 값이라고 지정
    var isDone: Bool
    var createdAt: Date
    
    @Transient var isBeingEdited: Bool = false
    // isBeingEdited은 저장하지 말아줘
    
    init(title: String, isDone: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}

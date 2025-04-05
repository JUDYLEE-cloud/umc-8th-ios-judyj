//
//  IdentifiableModel.swift
//  ThirdWorkBook
//
//  Created by 이주현 on 4/5/25.
//

import Foundation

struct IdentifiableUser: Identifiable {
    let id = UUID()
    var name: String
    var age: Int
}

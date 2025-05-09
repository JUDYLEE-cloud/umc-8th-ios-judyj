//
//  FourthExtraWorkBookApp.swift
//  FourthExtraWorkBook
//
//  Created by 이주현 on 4/12/25.
//

import SwiftUI
import SwiftData // 추가

@main
struct FourthExtraWorkBookApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self) // 추가
    }
}

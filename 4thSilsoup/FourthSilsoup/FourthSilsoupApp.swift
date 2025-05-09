//
//  FourthSilsoupApp.swift
//  FourthSilsoup
//
//  Created by 이주현 on 4/12/25.
//

import SwiftUI
import SwiftData

@main
struct FourthSilsoupApp: App {
    var body: some Scene {
        WindowGroup {
            ReceiptsView()
        }
        .modelContainer(for: ReceiptsModel.self)
    }
}

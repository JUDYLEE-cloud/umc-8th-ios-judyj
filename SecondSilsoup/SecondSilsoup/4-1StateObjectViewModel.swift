//
//  4-1StateObjectViewModel.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

class StateObjectViewModel: ObservableObject {
    @Published var inputText: String = ""
    init() {
        print("새로운 viewmodel 생성")
    }
}

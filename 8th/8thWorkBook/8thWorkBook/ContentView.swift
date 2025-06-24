//
//  ContentView.swift
//  8thWorkBook
//
//  Created by 이주현 on 6/23/25.
//

import SwiftUI

struct ContentView: View {
    // StateObject: View에서 직접 만들고, View가 살아있는 동안 계속 유지하겠다고 선언하는 속성 래퍼
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        VStack {
            Text("이름: \(viewModel.name)")
                .font(.title)
            
            TextField("이름 입력", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

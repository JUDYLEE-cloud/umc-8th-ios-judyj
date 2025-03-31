//
//  4-2StateTopView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct StateTopView: View {
    @StateObject var viewModel: StateObjectViewModel = .init()
    @State private var showBottomView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("here is top view")
                Text("text: \(viewModel.inputText)")
                TextField("text something", text: $viewModel.inputText)
                    .frame(width: 350)
                
                Button("call bottom view") {
                    showBottomView.toggle()
                }
                .sheet(isPresented: $showBottomView) {
                    StateBottomView(viewModel: viewModel)
                }
            }
        }
    }
}

#Preview {
    StateTopView()
}

//
//  4-3StateBottomView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct StateBottomView: View {
    
    @ObservedObject var viewModel: StateObjectViewModel
    
    init(viewModel: StateObjectViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("here is bottom view")
            Text("typing: \(viewModel.inputText)")
            Button("remove it") {
                viewModel.inputText = "removed!"
            }
            Spacer()
        }
    }
}

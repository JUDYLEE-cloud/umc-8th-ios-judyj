//
//  PublisedView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct PublisedView: View {
    @ObservedObject var viewModel: PublisedViewModel = .init()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            
            Button {
                viewModel.count += 1
            } label: {
                Text("증가 버튼")
            }

        }
    }
}

#Preview {
    PublisedView()
}

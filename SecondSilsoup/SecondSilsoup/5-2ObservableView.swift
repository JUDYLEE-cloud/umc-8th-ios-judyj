//
//  5-2ObservableView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct ObservableView: View {
    var viewModel: CounterViewModel = .init()
    
    var body: some View {
        VStack{
            Text("\(viewModel.count)")
            
            Button {
                viewModel.count += 1
            } label: {
                Text("increase it!")
            }
            .padding()

        }
    }
}

#Preview {
    ObservableView()
}

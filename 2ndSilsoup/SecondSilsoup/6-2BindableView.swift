//
//  6-2BindableView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct BindableView: View {
    private var counter = Counter()
    
    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            Button("Increment") {
                counter.count += 1
            }
            BindableChildView(counter: counter)
        }
    }
}

#Preview {
    BindableView()
}

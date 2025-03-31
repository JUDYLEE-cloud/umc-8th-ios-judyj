//
//  BindingView.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct BindingFirstView: View {
    
    //  @State private var isClosed: Bool = false
    // @State private var count: Int = 0
    @State private var usertext: String = ""
    
    var body: some View {
        VStack {
//            Text("Is door open? : \(isClosed)")
//            BindingSecondButtonView(isClosed: $isClosed)
            
            // Text("how many times you clicked? : \(count)")
            // BindingSecondButtonView(count: $count)
            
            Text("your typing... : \(usertext)")
            BindingSecondButtonView(usertext: $usertext)
        }
    }
}

#Preview {
    BindingFirstView()
}

//
//  6-4EnvironmentObject.swift
//  SecondSilsoup
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI


struct ContentView: View {
    @State private var showingsheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingsheet = true
        }
        .sheet(isPresented: $showingsheet, content: {
            EnvironmentObject()
        })
    }
}


struct EnvironmentObject: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("here is top view")
                
                Button("닫기") {
                    dismiss()
                }
                .padding()
            }
        }
    }
}


#Preview {
    ContentView()
}

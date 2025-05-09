//
//  11GeometryReader.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct GeometryReaderView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("view width: \(geometry.size.width)")
                Text("view height: \(geometry.size.height)")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.yellow)
        }
    }
}

#Preview {
    GeometryReaderView()
}

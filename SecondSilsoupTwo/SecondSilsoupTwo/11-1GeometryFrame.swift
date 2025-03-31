//
//  11-1GeometryFrame.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct GeometryFrame: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("뷰의 x좌표: \(geometry.frame(in: .global).origin.x)")
                Text("뷰의 y좌료: \(geometry.frame(in: .global).origin.y)")
            }
            .frame(width: 200, height: 150)
            .background(Color.orange)
            .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
        }
    }
}

#Preview {
    GeometryFrame()
}

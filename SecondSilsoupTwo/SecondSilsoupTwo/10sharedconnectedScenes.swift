//
//  10sharedconnectedScenes.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct sharedconnectedScenes: View {
    var screenSize: CGRect {
        guard let windowSence = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowSence.screen.bounds
    }
    
    var body: some View {
        VStack {
            Text("screen width: \(screenSize.width)")
            Text("screen height: \(screenSize.height)")
        }
    }
}

#Preview {
    sharedconnectedScenes()
}

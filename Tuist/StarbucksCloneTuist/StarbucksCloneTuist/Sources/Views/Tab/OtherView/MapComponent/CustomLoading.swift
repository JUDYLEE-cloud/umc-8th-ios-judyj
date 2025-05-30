//
//  CustomAlert.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 5/26/25.
//

import SwiftUI

struct CustomLoading: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Image(systemName: "arrow.trianglehead.clockwise")
                    .foregroundStyle(Color("green01"))
                
                Text(title)
                    .font(.mainTextSemiBold14())
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 15)
            }
        }
    }
}

#Preview {
    CustomLoading(title: "경로 탐색 중..")
}

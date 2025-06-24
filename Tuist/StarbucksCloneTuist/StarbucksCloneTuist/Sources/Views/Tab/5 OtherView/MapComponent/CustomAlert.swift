//
//  CustomAlert.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 5/26/25.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let dismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 118)
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                    .cornerRadius(6)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 2, y: 3)
                
                ZStack {
                    VStack {
                        Text(title)
                            .font(.mainTextSemiBold14())
                            .foregroundStyle(Color(.gray03))
                            .padding(.vertical, 15)
                        
                        Divider()
                            .foregroundStyle(Color(.gray01))
                        
                        Button(action: {
                            dismiss()
                        }) {
                            Text("확인")
                                .font(.mainTextSemiBold16())
                                .foregroundStyle(Color(.green02))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 3)
                        }
                        .contentShape(Rectangle())
                        
                    }
                   
                }
                
                
            }
            .padding(.horizontal, 33)
        }
    }
}

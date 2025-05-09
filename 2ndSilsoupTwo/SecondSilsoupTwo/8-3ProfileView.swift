//
//  8-3ProfileView.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("프로필 화면")
                .font(.largeTitle)
            
            Text("사용자 이름: \(userViewModel.username)")
                .font(.title)
            
            Button("이름 변경") {
                userViewModel.username = "설정 화면으로 가서 새로운 닉네임을 입력하세요"
            }
            .padding()
            .background(Color.blue)
            .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel())
}

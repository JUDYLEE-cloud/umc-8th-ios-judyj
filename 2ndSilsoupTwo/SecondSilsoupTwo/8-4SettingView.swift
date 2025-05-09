//
//  8-4SettingView.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text("닉네임 설정 화면")
                .font(.largeTitle)
            
            TextField("사용자 이름 변경", text: $userViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    SettingView()
        .environmentObject(UserViewModel())
}

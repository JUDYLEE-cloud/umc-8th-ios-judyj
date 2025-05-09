//
//  8-2ParentView.swift
//  SecondSilsoupTwo
//
//  Created by 이주현 on 3/31/25.
//

import SwiftUI

struct ParentView: View {
    
    @StateObject var userViewModel: UserViewModel = .init()
    
    var body: some View {
        NavigationStack {
            Text("현재 닉네임: \(userViewModel.username)")
                .font(.title)
            
            NavigationLink(
                "프로필 화면으로 이동") {
                    ProfileView().environmentObject(userViewModel)
                }
            NavigationLink(
                "설정 화면으로 이동") {
                    SettingView().environmentObject(userViewModel)
                }
        }
    }
}

#Preview {
    ParentView()
        .environmentObject(UserViewModel())
}

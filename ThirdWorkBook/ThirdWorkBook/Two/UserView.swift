//
//  IdentifiableView.swift
//  ThirdWorkBook
//
//  Created by 이주현 on 4/5/25.
//

import SwiftUI

struct UserView: View {
    @State private var users = [
        IdentifiableUser(name: "JudyJ", age: 20),
        IdentifiableUser(name: "Ivy", age: 18),
        IdentifiableUser(name: "Minbol", age: 19)
    ]
    
    var body: some View {
        NavigationView {
            List{
                ForEach($users) { $user in
                    NavigationLink(destination: UserEditView(user: $user)) {
                        HStack {
                            Text(user.name)
                            Spacer()
                            Text("she is \(user.age) old!")
                        }
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}

#Preview {
    UserView()
}

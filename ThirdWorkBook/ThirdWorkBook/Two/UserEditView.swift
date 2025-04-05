//
//  UserEditView.swift
//  ThirdWorkBook
//
//  Created by 이주현 on 4/5/25.
//

import SwiftUI

struct UserEditView: View {
    @Binding var user: IdentifiableUser
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            Stepper("Age: \(user.age)", value: $user.age, in: 18...100)
        }
    }
}

#Preview {
    UserEditView(user: .constant(IdentifiableUser(name: "judyj", age: 20)))
}

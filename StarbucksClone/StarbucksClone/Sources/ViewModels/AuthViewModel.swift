// 2주차에서 사용

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel = LoginModel(id: "", password: "")
    
    
}


class SignupViewModel: ObservableObject {
    @Published var signupModel: SignupModel = SignupModel(nickname: "", id: "", password: "", passwordConfirm: "")
    @AppStorage("usernickname") var storedNickname: String = ""
    @AppStorage("userid") var storedId: String = ""
    @AppStorage("userpassword") var storedPassword: String = ""
    
    func signup() {
        storedNickname = signupModel.nickname
        storedId = signupModel.id
        storedPassword = signupModel.password
        print("회원가입 시도 - stored에 저장된 닉네임: \(storedNickname), 아이디: \(storedId), 비밀번호 \(storedPassword)")
    }
}

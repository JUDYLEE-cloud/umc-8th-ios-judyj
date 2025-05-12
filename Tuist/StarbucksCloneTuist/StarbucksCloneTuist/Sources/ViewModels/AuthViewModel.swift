import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel = LoginModel(id: "", password: "")
    
//    @AppStorage("loginID") var loginID: String = ""
//    @AppStorage("loginPassword") var loginPassword: String = ""
    @Published var inputID: String = ""
    @Published var inputPassword: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @Published var loginFailed: Bool = false
    
    //  회원가입뷰에서 입력한 사용자 값 불러오기
    @AppStorage("userid") var storedId: String = ""
    @AppStorage("userpassword") var storedPassword: String = ""
    
    func login() {
        if inputID == storedId && inputPassword == storedPassword {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
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

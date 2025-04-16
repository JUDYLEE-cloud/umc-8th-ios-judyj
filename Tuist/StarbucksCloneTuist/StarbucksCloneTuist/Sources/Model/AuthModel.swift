//
//  LoginModel.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 3/26/25.
//

import Foundation

struct LoginModel {
    var id: String
    var password: String
    
    func login() {
        print("로그인 시도 - 아이디: \(id), 비밀번호: \(password)")
    }
}

struct SignupModel {
    var nickname: String
    var id: String
    var password: String
    var passwordConfirm: String
    
    var isPasswordMatching: Bool {
        return passwordConfirm.isEmpty || password == passwordConfirm
    }
}

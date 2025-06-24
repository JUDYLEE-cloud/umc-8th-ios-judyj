//
//  UserViewModel.swift
//  8thWorkBook
//
//  Created by 이주현 on 6/23/25.
//

import Foundation
import Combine

// ObservableObject: 이 객체의 값이 바뀌면 화면도 자동으로 업데이트
class UserViewModel: ObservableObject {
    // Publisher
    @Published var name: String = "JudyJ"
    
    // Combine에서 구독을 유지하기 위한 변수
    // Combine에서 Publisher을 구독하면, 구독을 관리하는 객체인 AnyCancellable이 자동으로 생기는데,
    // 이 구독 객체를 변수로 저장해두지 않으면 구독이 바로 사라져서 데이터 흐름이 멈춘다
    private var cancellables = Set<AnyCancellable>()
    
    // viewmodel이 만들어질때 실행되는 초기화 코드
    init() {
        $name
            .sink { newName in
                print("새 이름: \(newName)")
            } // sink: name 값이 바뀔 때마다 새로운 값을 받아서 newName에 할당
            .store(in: &cancellables) // 구독한 것을 cancellables에 저장해서 뷰모델이 있는 동안 구독이 유지되도록 함
        // .store: 구독 객체를 cancellables라는 set에 넣어줘, 라는 뜻
    }
}

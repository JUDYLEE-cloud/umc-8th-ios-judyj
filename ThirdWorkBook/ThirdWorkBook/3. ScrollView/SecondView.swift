//
//  ScrollPracticeSecondView.swift
//  ThirdWorkBook
//
//  Created by 이주현 on 4/6/25.
//

import SwiftUI

// 스크롤의 시작 위치 설정
struct SecondView: View {
    @State private var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            ScrollViewReader {proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(0..<50, id: \.self) { index in
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.3))
                                .id(index)
                                .padding()
                        }
                    }
                }
                .onChange(of: scrollToIndex) { _, newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }
            HStack {
                Button("Top") {scrollToIndex = 0}
                Button("Middle") {scrollToIndex = 25}
                Button("Buttom") {scrollToIndex = 49}
            }
        }
    }
}

#Preview {
    SecondView()
}

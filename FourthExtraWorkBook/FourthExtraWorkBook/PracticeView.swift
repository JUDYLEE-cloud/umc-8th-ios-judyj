import SwiftUI

struct CollectionDemoView: View {
    let words = ["Swift", "Kotlin", "Dart", "JavaScript", "Python"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("✅ 전체 컬렉션")
                .font(.headline)
            
            HStack {
                // indices 자동 추출
                ForEach(words.indices, id: \.self) { index in
                    // 인덱스 기반 접근
                    Text(words[index])
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            Divider()
            
            Text("🔹 첫 번째 요소")
                .font(.headline)
            // first 요소 가져오기
            Text(words.first ?? "없음")
                .padding()
                .background(.yellow.opacity(0.5))
                .cornerRadius(8)

            Divider()
            
            Text("🔹 슬라이스 (앞의 3개)")
                .font(.headline)
            HStack {
                // prefix: 슬라이스 생성
                ForEach(Array(words.prefix(3).enumerated()), id: \.offset) { (_, word) in
                    Text(word)
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}

#Preview {
    CollectionDemoView()
}

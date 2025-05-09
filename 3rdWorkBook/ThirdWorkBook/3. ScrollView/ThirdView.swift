import SwiftUI

// 화면 렌더링 후 2초 후 스크롤이 25번으로 이동함
// 프리뷰에 오류 뜨면 파일 이름에 3을 지우고 재실행
struct ThirdView: View {
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack {
                    ForEach(1...50, id: \.self) { index in
                        Text("Item \(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .padding(.horizontal)
                            .id(index) //. 각 아이템에 id를 부여해야 scrollTo가 동작함
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        proxy.scrollTo(25, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    ThirdView()
}

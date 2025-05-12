import SwiftUI

struct AIImageView: View {
    @State private var image: UIImage?
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            } else {
                Text("이미지를 생성하려면 버튼을 누르세요")
            }
            
            Button(isLoading ? "생성 중..." : "이미지 생성") {
                Task {
                    isLoading = true
                    do {
                        image = try await ImageServiceManager.shared.generateImage(prompt: "a cute fluffy cat wearing hip-hop jacket, sitting in a dj party", negativePrompt: "blurry, low quality, cropped")
                    } catch {
                        print("오류:", error)
                    }
                    isLoading = false
                }
            }
            .disabled(isLoading)
            .padding()
        }
    }
}

#Preview {
    AIImageView()
}

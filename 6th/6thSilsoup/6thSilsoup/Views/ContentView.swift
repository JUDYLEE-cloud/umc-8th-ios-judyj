import SwiftUI

struct ContentView: View {
    @State var showCameraView: Bool = false
    
    var body: some View {
        VStack {
            Button {
                showCameraView.toggle()
            } label: {
                Text("책 조회하기")
                    .font(.title)
                    .foregroundStyle(Color.black)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 0.5)
                            .stroke(Color.black, lineWidth: 2)
                    }
            }
        }
        .fullScreenCover(isPresented: $showCameraView) {
            ISBNScannerView()
        }
    }
}

#Preview {
    ContentView()
}

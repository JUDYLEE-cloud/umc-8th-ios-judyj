import SwiftUI

struct DetailNavView: View {
    let backAction: () -> Void
    
    var body: some View {
            HStack {
                Button {
                    backAction()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.black.opacity(0.4)))
                }
                
                Spacer()

                Image("exportIcon")
                    // .padding(8)
                    .background(Circle().fill(Color.black.opacity(0.4)))
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 8)
        }
    
}

struct DetailUnderView: View {
    var body: some View {
        Button {
            print("주문하기")
        } label: {
            ZStack {
                Color.white
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -5)

                
                GreenButton(title: "주문하기")
                    .padding(.horizontal, 10)
            }
            .frame(height: 73)
            // .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 1)
        }

    }
}

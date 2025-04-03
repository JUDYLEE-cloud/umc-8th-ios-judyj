import SwiftUI

struct AdvertiseView: View {
    var body: some View {
        VStack {
            Image("advertise")
                .frame(height: 720)
                .ignoresSafeArea(edges: .top)
            
            Spacer()
            
            UnderButtonGroup
        }
        .frame(width: 438, height: 920)
    }
    
    @Environment(\.dismiss) var dismiss
    var UnderButtonGroup: some View {
        VStack {
            Button {
                print("광고뷰 - 자세히 보기")
            } label: {
                GreenButton(title: "자세히 보기")
            }
            
            Button {
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "xmark")
                    Text("닫기")
                    Spacer()
                        .frame(width: 19)
                }
                .foregroundColor(Color("gray05"))
                .font(.mainTextLigth14)
                .padding(.top, 19)
            }

        }
        .frame(width: 402, height: 94)
    }
}

#Preview {
    AdvertiseView()
}

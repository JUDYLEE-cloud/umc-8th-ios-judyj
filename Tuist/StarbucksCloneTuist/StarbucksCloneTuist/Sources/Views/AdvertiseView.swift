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
                    Text("X 닫기")
                    Spacer()
                        .frame(width: 19)
                }
                .foregroundColor(Color("gray05"))
                .font(.mainTextLight14())
                .padding(.top, 19)
            }

        }
        .frame(height: 94)
        .padding(.horizontal, 19)
    }
}

#Preview {
    AdvertiseView()
}

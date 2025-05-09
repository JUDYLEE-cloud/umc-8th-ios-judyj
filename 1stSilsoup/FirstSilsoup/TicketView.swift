import SwiftUI

struct TicketView: View {
    var body: some View {
        ZStack {
            Image("TicketBackground")
                .resizable()
                .frame(width: 385, height: 385)
            VStack {
                Spacer()
                    .frame(height: 111)
                mainTitleGroup
                Spacer()
                    .frame(height: 100)
                mainBottomGroup
            }
        }
        .padding()
    }
}

private var mainTitleGroup: some View {
    VStack {
        Group {
            Text("마이펫의 이중생활 2")
                .font(.PretendardBold30)
                .shadow(color: .black.opacity(0.25), radius: 2, x:0, y: 4)
            Text("본인 + 동반 1인")
                .font(.PretendardLigth16)
            Text("30,100원")
                .font(.PretendardBold24)
        }
        .foregroundColor(.white)
    }
    .frame(height: 84)
}

private var mainBottomGroup: some View {
    VStack {
        Button {
            print("예매 확인 버튼 클릭")
        } label: {
            VStack {
                Group {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 18, height: 12)
                    Text("예매하기")
                        .font(.PretendardSemiBold18)
                        .foregroundColor(.white)
                }
                .foregroundColor(.white)
                .frame(width: 63, height: 15)
            }
        }

    }
}

#Preview {
    TicketView()
}

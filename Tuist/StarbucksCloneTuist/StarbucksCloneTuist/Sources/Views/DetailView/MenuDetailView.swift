import SwiftUI

struct MenuDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedOption: String = "ICED"
    let menuItem: ScrollMenuItem
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Image(menuItem.imageDetailName ?? "")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea(edges: .top)
                    .padding(.bottom, -55)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(menuItem.menuName)
                            .font(.mainTextSemiBold24())
                        
                        Image("new")
                    }
                    Text(menuItem.englishName ?? "")
                        .foregroundColor(Color("gray01"))
                        .font(.mainTextSemiBold14())
                    
                    Spacer()
                        .frame(height: 32)
                    
                    Text(menuItem.menudescription ?? "")
                        .font(.mainTextSemiBold13())
                        .foregroundColor(Color("gray06"))
                    
                    Spacer()
                        .frame(height: 35)
                    
                    if let price = menuItem.price {
                        Text("\(price)원")
                            .font(.mainTextBold24())
                    } else {
                        Text("가격 정보 없음")
                            .font(.mainTextBold24())
                    }
                    
                    if (menuItem.isHotAvailable == true) && (menuItem.isIcedAvailable == true) {
                        HStack(spacing: 0) {
                            ForEach(["HOT", "ICED"], id: \.self) { option in
                                Text(option)
                                    .font(.mainTextSemiBold18())
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        backgroundView(for: option)
                                    )
                                    .foregroundColor(textColor(for: option))
                                    .onTapGesture {
                                        selectedOption = option
                                    }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 999)
                                .fill(Color("gray07"))
                        )
                        .padding(.vertical, 16)
                    } else {
                        let (message, color): (String, Color) = {
                            if menuItem.isHotAvailable == true && menuItem.isIcedAvailable == false {
                                return ("HOT ONLY", .red)
                            } else if menuItem.isIcedAvailable == true && menuItem.isHotAvailable == false {
                                return ("ICED ONLY", .blue)
                            } else {
                                return ("해당 메뉴는 현재 제공되지 않습니다.", .gray)
                            }
                        }()
                        VStack {
                            Spacer()
                                .frame(height: 30)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 999)
                                    .fill(Color.clear)
                                    .stroke(Color("gray01"), lineWidth: 1)
                                    .frame(height: 36)
                                
                                Text(message)
                                    .font(.mainTextSemiBold13())
                                    .foregroundColor(color)
                            }
                        }
                    }
                } // 글씨 부분
                .padding(.horizontal, 10)
                .frame(height: 300)
                
                Spacer()
                
                DetailUnderView()
            }
            
            DetailNavView {
                dismiss()
            }
        }
        .navigationBarBackButtonHidden(true)// 최상위 ztasck
    }
    
    private func backgroundView(for option: String) -> some View {
        if selectedOption == option {
            return AnyView(
                ZStack {
                    RoundedRectangle(cornerRadius: 999)
                        .fill(Color("gray07"))
                    RoundedRectangle(cornerRadius: 999)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 1)
                }
            )
        } else {
            return AnyView(
                RoundedRectangle(cornerRadius: 999)
                    .fill(Color("gray07"))
            )
        }
    }
    
    private func textColor(for option: String) -> Color {
        if selectedOption == option {
            return option == "ICED" ? Color.blue : Color.red
        } else {
            return Color.gray
        }
    }
}

struct MenuDetailView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            MenuDetailView(menuItem: ScrollMenuItem(id: 105, imageName: "menu5", imageDetailName: "menu5detail", menuName: "아이스 카라멜 마끼아또", englishName: "Iced Caramel Macchiato", price: 6100, menudescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", isHotAvailable: true, isIcedAvailable: true))
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

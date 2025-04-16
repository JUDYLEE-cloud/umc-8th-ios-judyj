import SwiftUI

struct OtherView: View {
    @AppStorage("usernickname") private var storedNickname: String = ""
    // 사인업 뷰 모델로 불러오기
    
    var body: some View {
        NavigationStack {
            VStack {
                UpperBar
                ScrollView {
                    ZStack {
                        // Color(hex: 0xF8F8F8).ignoresSafeArea()
                        Color("white01").ignoresSafeArea()
                        VStack {
                            User
                            Spacer()
                            Pay
                            Divider()
                            Spacer()
                            CustomerHelp
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 30)
                        .frame(height: 683)
                    }
                }
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
            
    }
    
    
    private var UpperBar: some View {
            HStack {
                // labeledcontent: text와 button 같이 묶기
                LabeledContent {
                    Button {
                        print("로그아웃")
                    } label: {
                        Image("LogoutIcon")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                } label: {
                    Text("Other")
                        .font(.mainTextSemiBold24())
                }
            }
            .frame(height: 30)
            .padding(.vertical, 13)
            .padding(.horizontal, 23.5)
            .background(Color.white)
    }
    
    private var User: some View {
        VStack {
             Text("\(Text(storedNickname.isEmpty ? "(작성한 닉네임)" : storedNickname).foregroundColor(Color("green01"))) 님\n환영합니다! 🙌🏻")
                .font(.mainTextSemiBold24())
                .multilineTextAlignment(.center)
                .lineSpacing(10)
                .padding(.bottom, 24)
            
            // Spacer()
            
            HStack(spacing: 10.5) {
                WhiteBoxButton(image: "star", title: "별 히스토리")
                
                    // WhiteBoxButton(image: "receipt", title: "전자영수증")
                NavigationLink(destination: ReceiptView(viewModel: ReceiptsViewModel())) {
                    WhiteBoxButton(image: "receipt", title: "전자영수증")
                }
                WhiteBoxButton(image: "mymenu", title: "나만의 메뉴")
            }
        }
        .frame(height: 209)
    }
    private struct WhiteBoxButton: View {
        let image: String
        let title: String
        init(image: String, title: String) {
            self.image = image
            self.title = title
        }
        var body: some View {
                        VStack {
                            Image(image)
                                .frame(width: 48, height: 48)
                            
                            Text(title)
                                .font(.mainTextSemiBold16())
                                .foregroundColor(.black)
                        }
                        .frame(width: 102, height: 108)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x:0, y:0)
                        )
                }
    }
    
    private struct PayItem: View {
        let imageName: String
        let title: String
        
        var body: some View {
            Button {
                print("\(title) 클릭됨")
            } label: {
                HStack {
                    Image(imageName)
                        .frame(width: 42, height: 42)
                        // .padding(.trailing, -10)
                    Text(title)
                        .font(.mainTextSemiBold14())
                        .foregroundColor(.black)
                }
                .frame(width: 157, height: 32, alignment: .leading)
            }
            .buttonStyle(.plain)
        }
    }
    private var Pay: some View {
        VStack {
            HStack {
                Text("Pay")
                    .font(.mainTextSemiBold18())
                Spacer()
            }
            .padding(.bottom, 13)
            
            HStack {
                PayItem(imageName: "OtherIcon1", title: "스타벅스 카드 등록")
                Spacer()
                PayItem(imageName: "OtherIcon2", title: "카드 교환권 등록")
            }
            .padding(.vertical, 8)
            HStack {
                PayItem(imageName: "OtherIcon3", title: "쿠폰 등록")
                Spacer()
                PayItem(imageName: "OtherIcon4", title: "쿠폰 히스토리")
            }
            .padding(.vertical, 8)
            
        }
        .frame(height: 164)
        .padding(.horizontal, 10)
    }
    
    private var CustomerHelp: some View {
       VStack {
            HStack {
                Text("고객 지원")
                    .font(.mainTextSemiBold18())
                    .padding(.bottom, 8) // padding 원래 16인데 너무 길어서 줄임
                
                Spacer()
            }
           HStack {
               PayItem(imageName: "OtherIcon5", title: "스토어 케어")
               Spacer()
               PayItem(imageName: "OtherIcon6", title: "고객의 소리")
           }
           .padding(.vertical, 8)
           HStack {
               PayItem(imageName: "OtherIcon7", title: "매장 정보")
               Spacer()
               PayItem(imageName: "OtherIcon8", title: "반납기 정보")
           }
           .padding(.vertical, 8)
           HStack {
               PayItem(imageName: "OtherIcon9", title: "마이 스타벅스 리뷰")
               Spacer()
           }
           .padding(.vertical, 8)
        }
        .padding(.horizontal, 10)
    }
    
}

#Preview {
    OtherView()
}

import SwiftUI

struct HomeView: View {
    @AppStorage("usernickname") private var storedNickname: String = ""
    let eventImages: [EventItem] = EventItem.sampleEventItems
    let banner1Names = ["Banner3", "Banner4", "Banner5"]
    let banner2Names = ["Banner6", "Banner7", "Banner8"]
    
    var body: some View {
        // 최상위뷰만 navigationstack을 가지고 있어야 한다
        NavigationView {
            ScrollView {
                // 전체에 lazyvstack 줘도 좋을 듯?
                VStack(alignment: .leading, spacing: 20) {
                    // 1 골든 미모사 토끼
                    // 이미지 .offset 이용해서 글자를 조금 내려야 함
                    // zstack은 최상위 뷰에 맞추기 때문에 frame으로 이미지보다 큰 숫자 줘도 소용없음 (이라고 하는데 난 왜 되지..?)
                    ZStack(alignment: .topLeading) {
                        Image("top_img")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .frame(height: 226)
                            // .border(Color.red, width: 1)
                        
                        VStack {
                            Spacer()
                                .frame(height: 103)
                            
                            HStack {
                                Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                                    .font(.mainTextBold24())
                                    .padding(.leading, 20)
                                    .lineSpacing(5)
                                
                                Spacer()
                            }
                            
                            Spacer()
                                .frame(height: 20)
                            
                            HStack(alignment: .bottom) {
                                // 왼쪽 바
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("11★ until next Reward")
                                        .font(.mainTextSemiBold16())
                                        .foregroundColor(Color("brown02"))
                                    
                                    GeometryReader { geometry in
                                        ZStack(alignment: .leading) {
                                            Rectangle()
                                                .frame(height: 8)
                                                .foregroundColor(Color.gray.opacity(0.3))
                                                .cornerRadius(4)
                                            
                                            Rectangle()
                                                .frame(width: geometry.size.width * (1.0 / 12.0), height: 8)
                                                .foregroundColor(Color("brown02"))
                                                .cornerRadius(4)
                                        }
                                        .frame(width: 230)
                                    }
                                }
                                .frame(width: 255, height: 35)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("내용 보기")
                                        .font(.mainTextRegular13())
                                        .foregroundColor(Color("gray06"))
                                    
                                    HStack(alignment: .center, spacing: 7) {
                                        Text("1")
                                            .font(.mainTextSemiBold38())
                                            .foregroundColor(.black)
                                        Text("/")
                                            .font(.mainTextRegular18())
                                            .foregroundColor(.gray)
                                        Text("12★")
                                            .font(.mainTextSemiBold24())
                                            .foregroundColor(Color("brown02"))
                                    }
                                }
                                .frame(width: 108, height: 58)
                            }
                            .padding(.horizontal, 20) // 양 옆 여백
                            
                        }
                    }
                    .frame(height: 270) // 1 골든 미모사
                    
                    // 2 곰돌이
                    Image("Banner2")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 183)
                    
                    // 3 메뉴 스크롤
                    HorizontalMenuSectionView(
                        title: (
                            Text(storedNickname.isEmpty ? "설정 닉네임" : storedNickname)
                                .foregroundColor(Color("brown01")) +
                            Text("님을 위한 추천 메뉴")
                                .foregroundColor(.black)
                        ),
                        menuItems: ScrollMenuItem.drinkMenuImages
                    )
                    
                    // 4. blooming event 이미지
                    Image("eventBanner")
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 451)
                        .padding(.horizontal, 10)
                    
                    // 5. 론칭 이미지
                    Image("serviceSuscibe")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 199)
                    
                    // 6. 이벤트 스크롤
                    // 컴포넌트화 하기 - 여기에 frame 주면 안됨. max만 줄 수 있음
                    VStack(alignment: .leading) {
                        Text("What's New")
                            .font(.mainTextSemiBold24())
                            .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(eventImages) { scrollEventItem in
                                    VStack(alignment: .leading) {
                                        Image(scrollEventItem.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 242, height: 160)
                                            .padding(.bottom, 6)
                                        Text(scrollEventItem.eventName)
                                            .font(.mainTextSemiBold18())
                                            .padding(.bottom, 1)
                                        Text(scrollEventItem.eventDescription)
                                            .font(.mainTextRegular13())
                                            .foregroundColor(Color("gray03"))
                                            .lineLimit(2)
                                    }
                                    .frame(width: 242, height: 249)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    .frame(height: 295)
                    
                    // 7. 배너 3개
                    ForEach(banner1Names, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                    }
                    
                    // 8. 디저트 메뉴 스크롤
                    HorizontalMenuSectionView(title: Text("하루가 달콤해지는 디저트"), menuItems: ScrollMenuItem.dessertMenuImages)
                    
                    // 9. 마지막 배너 3개
                    ForEach(banner2Names, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                    }
                    
                    

                    
                }
            }
        }
        .navigationBarHidden(true)
    }
            } // 최상단 vstack

#Preview {
    HomeView()
}

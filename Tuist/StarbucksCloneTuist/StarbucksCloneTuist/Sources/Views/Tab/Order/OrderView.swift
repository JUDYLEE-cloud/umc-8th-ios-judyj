import SwiftUI

enum OrderTab: Int, CaseIterable {
    case allMenu = 0
    case myMenu = 1
    case cakeReservation = 2
    
    var title: String {
            switch self {
            case .allMenu: return "전체 메뉴"
            case .myMenu: return "나만의 메뉴"
            case .cakeReservation: return "홀케이크 예약"
            }
        }
}

struct OrderView: View {
    @State private var selectedTab: OrderTab = .allMenu
    @State private var showStoreSelectModal: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Order")
                        .font(.mainTextBold24())
                    Spacer()
                }
                .padding(.horizontal, 23)
                
                OrderNavigationBar(selectedTab: $selectedTab)
                
                Spacer()
                
                Group {
                    switch selectedTab {
                    case .allMenu: OrderMenuBodyView()
                    case .myMenu: MyMenuBody()
                    case .cakeReservation: CakeBody()
                    }
                }
                
                Spacer()
            }
            
            StoreSelect(showModal: $showStoreSelectModal)
        }
        .sheet(isPresented: $showStoreSelectModal) {
            StoreSelectModalView()
        }
    }
}

struct OrderNavigationBar: View {
    @Binding var selectedTab: OrderTab
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(OrderTab.allCases, id: \.self) { tab in
                    VStack(spacing: 0) {
                        Button {
                            withAnimation(.easeInOut) {
                                selectedTab = tab
                            }
                        } label: {
                            Text(tab.title)
                                .font(.mainTextBold16())
                                .foregroundColor(selectedTab == tab ? Color("black01") : Color("gray04"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                        }

                        // 초록색 막대기
                        if selectedTab == tab {
                            Rectangle()
                                .fill(Color("green01"))
                                .frame(height: 3)
                                .offset(y: 3)
                                .matchedGeometryEffect(id: "underline", in: animation)
                                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 3)
                        } else {
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 3)
                                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 3)
                        }
                            
                    }
                }
            }
            .background(Color.white)
        }
    }
}

//struct OrderNavigationBar: View {
//    @Binding var selectedTab: OrderTab
//    @Namespace private var animation
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            Button(action: {
//                selectedTab = .allMenu
//            }) {
//                ZStack(alignment: .bottom) {
//                    Text("전체 메뉴")
//                        .frame(maxHeight: .infinity, alignment: .center)
//                        .foregroundColor(selectedTab == .allMenu ? .black : .gray)
//                        .font(.mainTextBold16())
//                    
//                    Rectangle()
//                        .frame(height: selectedTab == .allMenu ? 3 : 1)
//                        .offset(y: selectedTab == .allMenu ? 3 : 0)
//                        .foregroundColor(selectedTab == .allMenu ? Color("green01") : Color(.white))
//                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
//                }
//                .frame(maxHeight: .infinity)
//                .frame(width: 115)
//            }
//            
//            Button(action: {
//                selectedTab = .myMenu
//            }) {
//                ZStack(alignment: .bottom) {
//                    Text("나만의 메뉴")
//                        .frame(maxHeight: .infinity, alignment: .center)
//                        .foregroundColor(selectedTab == .myMenu ? .black : .gray)
//                        .font(.mainTextBold16())
//                    
//                    Rectangle()
//                        .frame(height: selectedTab == .myMenu ? 3 : 1)
//                        .offset(y: selectedTab == .myMenu ? 3 : 0)
//                        .foregroundColor(selectedTab == .myMenu ? Color("green01") : Color(.white))
//                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
//                }
//                .frame(maxHeight: .infinity)
//                .frame(width: 115)
//            }
//            
//            Button(action: {
//                selectedTab = .cakeReservation
//            }) {
//                ZStack(alignment: .bottom) {
//                    HStack(spacing: 6) {
//                        Spacer()
//                            .frame(width: 10)
//                        
//                        Image("cake")
//                        
//                        Text("홀케이크 예약")
//                            .frame(maxHeight: .infinity, alignment: .center)
//                            .foregroundColor(Color("green01"))
//                            .font(.mainTextBold16())
//                    }
//                    
//                    Rectangle()
//                        .frame(height: selectedTab == .cakeReservation ? 3 : 1)
//                        .offset(y: selectedTab == .cakeReservation ? 3 : 0)
//                        .foregroundColor(selectedTab == .cakeReservation ? Color("green01") : Color(.white))
//                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
//                }
//                .frame( maxWidth: .infinity, maxHeight: .infinity)
//            }
//            
//        }
//        .frame(height: 53)
//        .padding(.vertical, 8)
//    }
//}

struct StoreSelect: View {
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Rectangle()
                    .fill(Color("black02"))
                    .frame(height: 60)
                
                VStack(spacing: 8) {
                    HStack {
                        Text("주문할 매장을 선택해 주세요")
                            .font(.mainTextSemiBold16())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.white)
                    }
                    
                    Rectangle()
                        .foregroundColor(Color("gray06"))
                        .frame(height: 1)
                }
                .padding(.horizontal, 20)
            } // zstack
            .onTapGesture {
                showModal = true
            }
        } // vstack
    }
}

#Preview {
    OrderView()
}

struct MyMenuBody: View {
    var body: some View {
        Text("나만의 메뉴")
    }
}

struct CakeBody: View {
    var body: some View {
        Text("홀케이크 예약")
    }
}

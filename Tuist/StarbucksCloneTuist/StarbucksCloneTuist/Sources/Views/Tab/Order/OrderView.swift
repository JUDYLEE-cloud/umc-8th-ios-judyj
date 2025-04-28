import SwiftUI

struct OrderView: View {
    @State private var selectedTab: Int = 0
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
                    case 0:
                        OrderMenuBodyView()
                    case 1:
                        MyMenuBody()
                    case 2:
                        CakeBody()
                    default:
                        EmptyView()
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
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            
            Button(action: {
                selectedTab = 0
            }) {
                ZStack(alignment: .bottom) {
                    Text("전체 메뉴")
                        .frame(maxHeight: .infinity, alignment: .center)
                        .foregroundColor(selectedTab == 0 ? .black : .gray)
                        .font(.mainTextBold16())
                    
                    Rectangle()
                        .frame(height: selectedTab == 0 ? 3 : 1)
                        .offset(y: selectedTab == 0 ? 3 : 0)
                        .foregroundColor(selectedTab == 0 ? Color("green01") : Color(.white))
                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
                }
                .frame(maxHeight: .infinity)
                .frame(width: 115)
            }
            
            Button(action: {
                selectedTab = 1
            }) {
                ZStack(alignment: .bottom) {
                    Text("나만의 메뉴")
                        .frame(maxHeight: .infinity, alignment: .center)
                        .foregroundColor(selectedTab == 1 ? .black : .gray)
                        .font(.mainTextBold16())
                    
                    Rectangle()
                        .frame(height: selectedTab == 1 ? 3 : 1)
                        .offset(y: selectedTab == 1 ? 3 : 0)
                        .foregroundColor(selectedTab == 1 ? Color("green01") : Color(.white))
                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
                }
                .frame(maxHeight: .infinity)
                .frame(width: 115)
            }
            
            Button(action: {
                selectedTab = 2
            }) {
                ZStack(alignment: .bottom) {
                    HStack(spacing: 6) {
                        Spacer()
                            .frame(width: 10)
                        
                        Image("cake")
                        
                        Text("홀케이크 예약")
                            .frame(maxHeight: .infinity, alignment: .center)
                            .foregroundColor(Color("green01"))
                            .font(.mainTextBold16())
                    }
                   
                    Rectangle()
                        .frame(height: selectedTab == 2 ? 3 : 1)
                        .offset(y: selectedTab == 2 ? 3 : 0)
                        .foregroundColor(selectedTab == 2 ? Color("green01") : Color(.white))
                        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
                }
                .frame( maxWidth: .infinity, maxHeight: .infinity)
            }
    
        }
        .frame(height: 53)
        .padding(.vertical, 8)
    }
}

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

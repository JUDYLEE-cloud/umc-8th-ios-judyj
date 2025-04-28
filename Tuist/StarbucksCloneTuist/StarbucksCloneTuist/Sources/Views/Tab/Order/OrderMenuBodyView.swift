import SwiftUI

struct OrderMenuBodyView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        OrderMenuBodyNavigation(selectedTab: $selectedTab)
        
        Group {
            ScrollView(showsIndicators: false) {
                switch selectedTab {
                case 0: DrinkBodyView()
                case 1: Text("푸드")
                case 2: Text("상품")
                default: EmptyView()
                }
            }
            .padding(.horizontal, 30)
        }
        
    }
    
}

struct DrinkBodyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(OrderDrinkMenuItem.orderMenuImages) { item in
                HStack(spacing: 16) {
                    Image(item.imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top, spacing: 1) {
                                Text(item.menuName)
                                    .font(.mainTextSemiBold16())
                                    .foregroundColor(Color("gray06"))
                                
                                if item.new == true {
                                    Circle()
                                        .fill(Color("green01"))
                                        .frame(width: 5, height: 5)
                                        .padding(.top, 2)
                                }
                            }
                        }
                        
                        Text(item.englishName)
                            .font(.mainTextSemiBold13())
                            .foregroundColor(Color("gray03"))
                    }
                    
                    Spacer()
                }
                .frame(height: 60)
                .padding(.top, 19)
            }
        }
    }
}

struct OrderMenuBodyNavigation: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                Button {
                    selectedTab = 0
                } label: {
                    Text("음료")
                        .font(.mainTextSemiBold16())
                        .foregroundColor(selectedTab == 0 ? .black : Color("gray04"))
                    Image("new")
                        .padding(.leading, -7)
                }
                
                Button {
                    selectedTab = 1
                } label: {
                    Text("푸드")
                        .font(.mainTextSemiBold16())
                        .foregroundColor(selectedTab == 1 ? .black : Color("gray04"))
                    Image("new")
                        .padding(.leading, -7)
                }
                
                Button {
                    selectedTab = 2
                } label: {
                    Text("상품")
                        .font(.mainTextSemiBold16())
                        .foregroundColor(selectedTab == 2 ? .black : Color("gray04"))
                    Image("new")
                        .padding(.leading, -7)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 23)
            .frame(height: 52)
            
            Divider()
        }
    }
}

#Preview {
    OrderMenuBodyView()
}

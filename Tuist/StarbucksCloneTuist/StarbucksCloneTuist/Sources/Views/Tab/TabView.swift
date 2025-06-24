import SwiftUI

// 레이블 사이 간격 주는 법?
struct CustomTabView: View {
    @State private var selectedTab = 0
    @State private var showAdForShop = false
    // @State private var hasSeenAd = false
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label{
                            Text("Home")
                                 } icon: {
                                Image(selectedTab == 0 ? "icon1-1" : "icon1")
                            }
                        Spacer(minLength: 44)
                    }
                    .tag(0)

                PayView()
                    .tabItem {
                        Label{
                            Text("Pay")
                                 } icon: {
                                Image(selectedTab == 1 ? "icon2-2" : "icon2")
                            }
                    }
                    .tag(1)

                OrderView()
                    .tabItem {
                        Label{
                            Text("Order")
                                 } icon: {
                                Image(selectedTab == 2 ? "icon3-3" : "icon3")
                            }
                    }
                    .tag(2)

                ShopView()
                    .fullScreenCover(isPresented: $showAdForShop) {
                        AdvertiseView(isActivate: $showAdForShop)
                    }
                    .tabItem {
                        Label{
                            Text("Shop")
                                 } icon: {
                                Image(selectedTab == 3 ? "icon4-4" : "icon4")
                            }
                    }
                    .tag(3)

                OtherView()
                    .zIndex(1)
                    .tabItem {
                        Label{
                            Text("Other")
                                 } icon: {
                                Image(selectedTab == 4 ? "icon5-5" : "icon5")
                            }
                    }
                    .tag(4)
            }
            .background(Color.white.ignoresSafeArea())
            .tabViewStyle(DefaultTabViewStyle())
            .tint(Color("green01"))
            .zIndex(0)
            .onChange(of: selectedTab) {
                if selectedTab == 3 {
                    showAdForShop = true
                }
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            CustomTabView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
 
//#Preview {
//    CustomTabView()
//}

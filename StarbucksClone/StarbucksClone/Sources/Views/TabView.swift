import SwiftUI

// 레이블 사이 간격 주는 법?

struct CustomTabView: View {
    @State private var selectedTab = 0
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Text("First Content")
                    .tabItem {
                        Label{
                            Text("Home")
                                 } icon: {
                                Image(selectedTab == 0 ? "icon1-1" : "icon1")
                            }
                        Spacer(minLength: 44)
                    }
                    .tag(0)

                Text("Second Content")
                    .tabItem {
                        Label{
                            Text("Pay")
                                 } icon: {
                                Image(selectedTab == 1 ? "icon2-2" : "icon2")
                            }
                    }
                    .tag(1)

                Text("Third Content")
                    .tabItem {
                        Label{
                            Text("Order")
                                 } icon: {
                                Image(selectedTab == 2 ? "icon3-3" : "icon3")
                            }
                    }
                    .tag(2)

                Text("Fourth Content")
                    .tabItem {
                        Label{
                            Text("Shop")
                                 } icon: {
                                Image(selectedTab == 3 ? "icon4-4" : "icon4")
                            }
                    }
                    .tag(3)

                OtherView()
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
        }
        .padding(.top, 10)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}

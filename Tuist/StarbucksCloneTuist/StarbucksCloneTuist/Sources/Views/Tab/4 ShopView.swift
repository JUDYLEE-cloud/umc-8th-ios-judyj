import SwiftUI

struct ShopView: View {
    // let HomeScrollProductItem = []
    
    var body: some View {
        ZStack {
            Color("white01")
                .ignoresSafeArea()
            
            ScrollView() {
                VStack(spacing: 0) {
                    Text("Starbucks Online Store")
                        .font(.mainTextBold24())
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 1. 배너 넘기기
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 28) {
                            Image("ShopBanner1")
                            Image("ShopBanner2")
                            Image("ShopBanner3")
                        }
                    }
                    .frame(height: 216)
                    
                    Spacer()
                    
                    // 2. all products
                    VStack(alignment: .leading) {
                        Text("All Products")
                            .foregroundColor(.black)
                            .font(.mainTextBold24())
                            .padding(.bottom, 16)
                        
                        ShopHorizontalMenuSectionView(
                            menuItems: HomeScrollMenuItem.homeMenuImages
                        )
                    }
                    
                    Spacer()
                    
                    // 3. Best Items
                    VStack(alignment: .leading) {
                        Text("Best Items")
                            .foregroundColor(.black)
                            .font(.mainTextBold24())
                            .padding(.bottom, 16)
                        
                        ShopBestitemsHorizontalSectionView(menuItems: HomeScrollBestItem.homeBestImages)
                    }
                    
                    Spacer()
                    
                    // 4. New Products
                    VStack(alignment: .leading) {
                        Text("New Products")
                            .foregroundColor(.black)
                            .font(.mainTextBold24())
                            .padding(.bottom, 16)
                        
                        ShopNewitemsHorizontalSectionView(menuItems: HomeScrollBestItem.homenewImages)
                    }
                }
                .frame(height: 1550)
            } // scrollview
            .padding(.horizontal, 16)
        }
        //.frame(height: 1564)
    } // 최상단 zstack
}

struct AdWrapperView: View {
    @State private var isAdDismiised = false
    @State private var showAdForShop = false // Added state variable
    
    var body: some View {
        ZStack {
            ShopView()
                .fullScreenCover(isPresented: $showAdForShop, onDismiss: {
                    isAdDismiised = true
                }) {
                    AdvertiseView(isActivate: $showAdForShop)
                }
        }
    }
}

//#Preview {
//    ShopView()
//}

struct ShopView_Previews: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            ShopView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

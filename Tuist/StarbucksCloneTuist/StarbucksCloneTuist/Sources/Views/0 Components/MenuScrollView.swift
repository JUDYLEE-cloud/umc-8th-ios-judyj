import SwiftUI

struct HorizontalMenuSectionView: View {
    let menuItems: [ScrollMenuItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    ForEach(menuItems) { item in
                        NavigationLink(destination: MenuDetailView(menuItem: item)) {
                            VStack(spacing: 16) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 130)
                                    .cornerRadius(12)
                                Text(item.menuName)
                                    .font(.mainTextSemiBold14())
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}

struct ShopHorizontalMenuSectionView: View {
    let menuItems: [HomeScrollMenuItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                LazyHStack(spacing: 17) {
                    ForEach(menuItems) { item in
                            VStack(spacing: 16) {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(12)
                                Text(item.menuName)
                                    .font(.mainTextSemiBold14())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(height: 108)
            }
        }
    }
}

struct ShopBestitemsHorizontalSectionView: View {
    let menuItems: [HomeScrollBestItem]
    @State private var currentPage = 0
    
    var body: some View {
        // menuitems 배열을 4개씩 묶은 chunkedItemsd을 만듦
        let chunkedItems = menuItems.chunked(into: 4)
        
        VStack {
            TabView(selection: $currentPage) {
                ForEach(chunkedItems.indices, id: \.self) { index in
                    let items = chunkedItems[index]
                    HStack {
                        // 2개의 gridItem으로 구성된 수직 그리드
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 0, alignment: .leading),
                                   GridItem(.flexible(), spacing: 0, alignment: .trailing)
                        ], spacing: 32) {
                            ForEach(items)  { item in
                                VStack(alignment: .leading) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity, maxHeight: 157)
                                        .frame(height: 157)
                                        .cornerRadius(12)
                                        .padding(.bottom, 12)
                                    
                                    Text(item.menuName)
                                        .font(.mainTextSemiBold14())
                                    
                                    Spacer().frame(height: 4)
                                    Text(item.volume != nil ? "\(item.volume!)ml" : " ")
                                        .font(.mainTextSemiBold14()
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: 157, height: 208)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 470, maxHeight: 470, alignment: .top)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            HStack(spacing: 8) {
                ForEach(0..<chunkedItems.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.black : Color.clear)
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 8)
        }
        .frame(height: 450)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

struct ShopNewitemsHorizontalSectionView: View {
    let menuItems: [HomeScrollBestItem]
    
    var body: some View {
        HStack {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 0, alignment: .leading),
                GridItem(.flexible(), spacing: 0, alignment: .trailing)
            ], spacing: 32) {
                ForEach(menuItems) { item in
                    VStack(alignment: .leading) {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 157)
                            .frame(height: 157)
                            .cornerRadius(12)
                            .padding(.bottom, 12)
                        
                        Text(item.menuName)
                            .font(.mainTextSemiBold14())
                        
                        Spacer().frame(height: 4)
                        Text(item.volume != nil ? "\(item.volume!)ml" : " ")
                            .font(.mainTextSemiBold14())
                    }
                    .frame(width: 157, height: 208)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 470, maxHeight: 470, alignment: .top)
        }
        .frame(height: 450)
    }
}


#Preview {
    ShopNewitemsHorizontalSectionView(menuItems: HomeScrollBestItem.homenewImages)
}

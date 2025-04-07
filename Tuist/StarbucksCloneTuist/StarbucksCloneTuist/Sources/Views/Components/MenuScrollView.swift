import SwiftUI

struct HorizontalMenuSectionView: View {
    let title: Text
    let menuItems: [ScrollMenuItem]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading) {
                title
                    .font(.mainTextBold24())
                    .padding(.leading, 20)
    
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
                .padding(.horizontal)
            }
        }
    }
}

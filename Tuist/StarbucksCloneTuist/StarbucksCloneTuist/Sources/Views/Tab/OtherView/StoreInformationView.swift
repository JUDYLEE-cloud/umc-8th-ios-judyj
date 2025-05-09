import SwiftUI

struct StoreInformationView: View {
    @State private var selectedTab: Int = 0
    
    @Bindable private var viewModel: SearchMapViewModel = .init()
    @State private var searchText = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // 제일 상단바
            ZStack {
                Text("매장 찾기")
                    .font(.mainTextMedium16())
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.black)
                    }

                    Spacer()
                }
                .padding(.horizontal, 33)
            }
            .padding(.top, 17)
            
            // 탭뷰
            HStack {
                Button {
                    selectedTab = 0
                } label: {
                    VStack(spacing: 0) {
                        Text("매장 찾기")
                            .font(.mainTextSemiBold24())
                            .foregroundStyle(Color.black)
                            .padding(.bottom, 3)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 120, height: 5)
                            .foregroundStyle(selectedTab == 0 ?  Color("brown02") : Color.clear)
                    }
                    .frame(height: 43)
                }
                
                Button {
                    selectedTab = 1
                } label: {
                    VStack(spacing: 0) {
                        Text("길찾기")
                            .font(.mainTextSemiBold24())
                            .foregroundStyle(Color.black)
                            .padding(.bottom, 3)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 120, height: 5)
                            .foregroundStyle(selectedTab == 1 ?  Color("brown02") : Color.clear)
                    }
                    .frame(height: 43)
                }
            }
            .padding(.vertical, 17)
            
            Group {
                switch selectedTab {
                case 0: StoreMapView(viewModel: viewModel, searchText: $searchText)
                case 1: Text("길찾기")
                default: EmptyView()
                }
            }
        
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    StoreInformationView()
}

import SwiftUI

struct StoreInformationView: View {
    @State private var selectedTab: Int = 0
    @State private var isShowingNoneResultAlert = false
    
    @State private var isMapRouteLoading = false
    @StateObject private var routeViewModel = RouteViewModel()
    
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
                case 0:
                    AnyView(MapResultView(viewModel: routeViewModel))
                case 1:
                    AnyView(FindMapVIew(isShowingNoneResultAlert: $isShowingNoneResultAlert, selectedTab: $selectedTab, viewModel: routeViewModel, isMapRouteLoading: $isMapRouteLoading))
                default:
                    AnyView(EmptyView())
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .overlay {
            if isShowingNoneResultAlert {
                CustomAlert(title: "검색 결과가 존재하지 않습니다.") {
                    isShowingNoneResultAlert = false
                }
                .ignoresSafeArea()
            }
        }
        .overlay {
            if isMapRouteLoading {
                CustomLoading(title: "경로 탐색 중..")
            }
        }
    }
}

#Preview {
    StoreInformationView()
}

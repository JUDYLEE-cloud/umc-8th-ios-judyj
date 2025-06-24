import SwiftUI
import MapKit

struct StoreSelectModalView: View {
    @State private var isMapView = false
    
    @Bindable private var viewModel: SearchMapViewModel = .init()
    @Bindable private var locationManager: LocationManager = .shared
    @State private var searchText = ""
    @State private var keywordSearchText = ""
    
    @StateObject private var listViewModel = JSONParsingViewModel()
    
    @State private var selectedTab: Int = 0

    
    var body: some View {
        VStack {
            UpperBar(isMapView: $isMapView)
                .padding(.top, 11)
    
            // 지도 형식
            if isMapView {
                TextField("검색", text: $searchText, onCommit: {
                    let fallbackLocation = CLLocation(latitude: 37.5665, longitude: 126.9780) // 서울
                    let location = locationManager.currentLocation ?? fallbackLocation
                    viewModel.search(query: searchText, to: location)
                })
                    .font(.mainTextSemiBold12())
                    .foregroundStyle(Color.gray)
                    .padding(.vertical, 4)
                    .padding(.leading, 7)
                    .background(Color("gray08"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.bottom, 14)
                
                StoreMapView(viewModel: viewModel, searchText: $searchText)
                    .padding(.horizontal, -32.5)
            } else {
                // 리스트 형식
                TextField("검색", text: $keywordSearchText)
                    .font(.mainTextSemiBold12())
                    .foregroundStyle(Color.gray)
                    .padding(.vertical, 4)
                    .padding(.leading, 7)
                    .background(Color("gray08"))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                  
                Spacer()
                    .frame(height: 22)
                
                StoreListUpperBar(selectedTab: $selectedTab)
                
                Group {
                    switch selectedTab {
                    case 0:
                        StoreListView(
                            jsonviewModel: listViewModel,
                            keywordSearchText: $keywordSearchText,
                            locationManager: locationManager
                        )
                    case 1: FavoriteStoreList()
                    default: EmptyView()
                    }
                }
                
            }
            
        }
        .padding(.horizontal, 32.5)
        .onAppear {
            listViewModel.loadMapInfo { result in
                switch result {
                case .success(_): break
                case .failure(_): print("json 파일 로드 실패")
                }
            }
            
            if let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String {
                print("🔑 GOOGLE_API_KEY: \(apiKey)")
            } else {
                print("❌ GOOGLE_API_KEY를 가져올 수 없습니다.")
            }
            
        }
    }
}


struct StoreListView: View {
    @ObservedObject var jsonviewModel: JSONParsingViewModel
    @Binding var keywordSearchText: String
    @Bindable var locationManager: LocationManager
    
    @StateObject private var viewModel = StoreSelectModalViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
                .frame(height: 20)
            if let mapInfo = jsonviewModel.mapInfo {
                let userLocation = locationManager.currentLocation ?? CLLocation(latitude: 37.5665, longitude: 126.9780)
                
                let sortedFeatures = mapInfo.features
                    .filter { feature in
                        keywordSearchText.isEmpty ||
                        feature.properties.storeName.localizedCaseInsensitiveContains(keywordSearchText) ||
                        feature.properties.address.localizedCaseInsensitiveContains(keywordSearchText)
                    }
                    .map { feature -> (FeatureModel, Double) in
                        let storeLocation = CLLocation(latitude: feature.geometry.coordinates[1], longitude: feature.geometry.coordinates[0])
                        let distance = userLocation.distance(from: storeLocation)
                        return (feature, distance)
                    }
                    .sorted { $0.1 < $1.1 }
                
                LazyVStack(spacing: 0) {
                    ForEach(sortedFeatures, id: \.0.id) { feature, distance in
                        let storeCategory = StoreCategory(categoryString: feature.properties.category)
                                        
                        HStack(spacing: 0) {
                            if let url = viewModel.storeImageURL {
                                            AsyncImage(url: url) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 200, height: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                        } else {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 200, height: 200)
                                                .onAppear {
                                                    Task {
                                                        await viewModel.loadImage(for: feature.properties.storeName)
                                                    }
                                                }
                                        }
                                                
                            
                            VStack(alignment: .leading) {
                                Text(feature.properties.storeName)
                                    .font(.mainTextSemiBold13())
                                    .foregroundColor(Color("black03"))
                                
                                Text(feature.properties.address)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color("gray02"))
                                
                                Spacer()
                                
                                HStack(alignment: .bottom, spacing: 4) {
                                    switch storeCategory {
                                    case .reserve:
                                        Image("reserve")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    case .drive:
                                        Image("drive")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    case .normal:
                                        Color.clear
                                            .frame(width: 18, height: 18)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(formatDistance(distance))
                                        .font(.system(size: 12))
                                }
                            }
                            .padding(.vertical, 6)
                            .frame(height: 83)
                            .padding(.leading, 16)
                        }
                        .padding(.bottom, 8)
                    }
                }
            } else {
                Text("로딩 중...")
            }
        }
    }
    
    private func formatDistance(_ distance: Double) -> String {
        if distance >= 1000 {
            return String(format: "%.1fkm", distance / 1000)
        } else {
            return String(format: "%.0fm", distance)
        }
    }
}

struct StoreListUpperBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    selectedTab = 0
                } label: {
                    Text("가까운 매장")
                        .font(selectedTab == 0 ? .mainTextSemiBold13() : .mainTextRegular13())
                        .foregroundColor(selectedTab == 0 ? Color("black03") : Color("gray03"))
                }
                .buttonStyle(.plain)
                
                Rectangle()
                    .frame(width: 1, height: 12)
                    .foregroundStyle(Color("gray02"))
                
                Button {
                    selectedTab = 1
                } label: {
                    Text("자주 가는 매장")
                        .font(selectedTab == 1 ? .mainTextSemiBold13() : .mainTextRegular13())
                        .foregroundColor(selectedTab == 1 ? Color("black03") : Color("gray03"))
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding(.bottom, 17)
            
            Divider()
        }
    }
}

enum StoreCategory {
    case reserve
    case drive
    case normal

    init(categoryString: String) {
        if categoryString.contains("리저브") {
            self = .reserve
        } else if categoryString.contains("DT") {
            self = .drive
        } else {
            self = .normal
        }
    }
}

struct UpperBar: View {
    @Binding var isMapView: Bool
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 4)
                .foregroundColor(Color("gray04"))
            
            ZStack {
                Text("매장 설정")
                    .font(.system(size: 16))
                HStack {
                    Spacer()
                    
                    Button {
                        isMapView.toggle()
                    } label: {
                        Image(systemName: isMapView ? "list.bullet" : "map")
                            .foregroundColor(Color("gray04"))
                    }
                }
            }
            .padding(.vertical, 20)
        }
    }
}

struct FavoriteStoreList: View {
    var body: some View {
        VStack {
            Text("자주 가는 매장 리스트")
                .padding()
            Spacer()
        }
    }
}

import SwiftUI
import MapKit

struct StoreMapView: View {
    @Bindable var viewModel: SearchMapViewModel
    @Bindable private var locationManager: LocationManager = .shared
    @Binding var searchText : String
    
    @StateObject var jsonViewModel = JSONParsingViewModel()
    @Namespace var mapScope
    
    @State private var isMapInitialized = false
    @State private var showThisLocationButton = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $viewModel.cameraPosition, bounds: .none, interactionModes: .all, scope: mapScope, content: {
                
                // 스타벅스
                if let mapInfo = jsonViewModel.mapInfo {
                    ForEach(mapInfo.features.filter { feature in
                        guard let center = viewModel.currentMapCenter else { return false }
                        let latRange = (center.latitude - 0.05)...(center.latitude + 0.05)
                        let lonRange = (center.longitude - 0.05)...(center.longitude + 0.05)
                        return latRange.contains(feature.geometry.coordinates[1]) &&
                               lonRange.contains(feature.geometry.coordinates[0])
                    }) { feature in
                        let coordinate = CLLocationCoordinate2D(latitude: feature.geometry.coordinates[1],
                                                                longitude: feature.geometry.coordinates[0])
                        Annotation(feature.properties.storeName, coordinate: coordinate) {
                            ZStack{
                                Image("StarbucksPoint")
                                
                                Image("StarbucksLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.bottom, 8)
                                    
                            }
                        }
                    }
                }
                
                // 다른 검색지
                ForEach(viewModel.searchResults, id: \.id, content: { place in
                    if let coordinate = place.mapItem.placemark.location?.coordinate {
                        Annotation(place.mapItem.name ?? "이름없음", coordinate: coordinate, content: {
                            Image(systemName: "mappin")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundStyle(Color.red)
                        })
                    }
                })
                
            })
            .onAppear {
                jsonViewModel.loadMapInfo { result in
                    switch result {
                    case . success(_): break
                    case .failure(_): print("json 파일 지도에 로드 실패")
                    }
                }
                
                if let userLocation = locationManager.currentLocation?.coordinate {
                    viewModel.setInitialCameraPosition(location: userLocation)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isMapInitialized = true
                    }
            }
            .onMapCameraChange { context in
                // 지도 중심 좌표 갱신
                viewModel.currentMapCenter = context.camera.centerCoordinate
                if isMapInitialized {
                        showThisLocationButton = true
                    }
            }
            
            // 사용자 현재 위치로 돌아오기
            HStack {
                Spacer()
                
                MapUserLocationButton(scope: mapScope)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.clear)
                        )
            }
            .padding(16)
            
            
            if showThisLocationButton {
                VStack {
                    Button(action: {
                                   if let center = viewModel.currentMapCenter {
                                       let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
                                       viewModel.search(query: searchText, to: location)
                                       jsonViewModel.loadMapInfo { _ in }
                                   }
                               }) {
                                   Text("이 지역 검색")
                                       .font(.system(size: 13))
                                       .foregroundColor(Color("gray06"))
                                       .padding(.horizontal, 16)
                                       .padding(.vertical, 9)
                                       .background(Color.white)
                                       .cornerRadius(20)
                                       .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
                               }
                               .padding([.horizontal, .top])
                    
                    Spacer()
                }
            }
            
        }
        .frame(maxHeight: .infinity)
        .mapScope(mapScope)
    }
}

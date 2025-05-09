import SwiftUI
import MapKit


struct SearchMapView: View {
    @Bindable private var viewModel: SearchMapViewModel = .init()
    @Bindable private var locationManager: LocationManager = .shared
    @State private var searchText = ""

    var body: some View {
        VStack {
            TextField("장소를 검색하세요", text: $searchText, onCommit: {
                let fallbackLocation = CLLocation(latitude: 37.5665, longitude: 126.9780) // 서울
                let location = locationManager.currentLocation ?? fallbackLocation
                viewModel.search(query: searchText, to: location)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            Map(position: $viewModel.cameraPosition, bounds: .none, interactionModes: .all, content: {
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
            .onMapCameraChange { context in
                // 지도 중심 좌표 갱신
                viewModel.currentMapCenter = context.camera.centerCoordinate
            }
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
            Button(action: {
                           if let center = viewModel.currentMapCenter {
                               let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
                               viewModel.search(query: searchText, to: location)
                           }
                       }) {
                           Text("이 지역에서 재검색")
                               .font(.headline)
                               .foregroundColor(.white)
                               .padding()
                               .frame(maxWidth: .infinity)
                               .background(Color.blue)
                               .cornerRadius(10)
                       }
                       .padding([.horizontal, .top])

            List(viewModel.searchResults) { place in
                VStack(alignment: .leading) {
                    Text(place.mapItem.name ?? "이름 없음")
                        .font(.headline)
                    Text(place.mapItem.placemark.title ?? "")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

#Preview {
    SearchMapView()
}

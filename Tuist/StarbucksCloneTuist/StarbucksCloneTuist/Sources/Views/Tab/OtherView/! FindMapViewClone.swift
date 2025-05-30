//import SwiftUI
//import CoreLocation
//
//struct FindMapVIewClone: View {
//    // body 위에 property, 밑에 method
//    @Binding var isShowingNoneResultAlert: Bool
//    @ObservedObject var viewModel: RouteViewModel
//    public init(isShowingNoneResultAlert: Binding<Bool>, viewModel: RouteViewModel) {
//        self._isShowingNoneResultAlert = isShowingNoneResultAlert
//        self.viewModel = viewModel
//    }
//    
//    // 출발/도착 검색 입력
//    enum SearchType {
//        case start
//        case end
//    }
//    @State private var startPointSearch = ""
//    @State private var endPointSearch = ""
//    @State private var startCoordinate: Coordinate? = nil
//    @State private var endCoordinate: Coordinate? = nil
//    
//    // 현재위치
//    @State private var isAuthorized = false
//    private var locationManager = CLLocationManager()
//    @StateObject private var locationDelegate = LocationDelegate { _ in }
//    func fetchCurrentLocationAddress() {
//        if isAuthorized {
//            locationManager.requestLocation()
//            locationDelegate.onUpdate = { location in
//                let geocoder = CLGeocoder()
//                geocoder.reverseGeocodeLocation(location) { placemarks, error in
//                    if let placemark = placemarks?.first {
//                        let country = placemark.country ?? ""
//                        let adminArea = placemark.administrativeArea ?? ""
//                        let locality = placemark.locality ?? ""
//                        let subLocality = placemark.subLocality ?? ""
//                        let thoroughfare = placemark.thoroughfare ?? ""
//                        let subThoroughfare = placemark.subThoroughfare ?? ""
//                        
//                        let address = "\(country) \(adminArea) \(locality) \(subLocality) \(thoroughfare) \(subThoroughfare)"
//                        startPointSearch = address
//                    }
//                }
//                let lon = location.coordinate.longitude
//                let lat = location.coordinate.latitude
//                startCoordinate = Coordinate(lon: lon, lat: lat)
//            }
//        }
//    }
//    
//    private func updateStartCoordinate(from place: Place) {
//        if let xStr = place.x, let yStr = place.y,
//           let lon = Double(xStr), let lat = Double(yStr) {
//            startCoordinate = Coordinate(lon: lon, lat: lat)
//        } else {
//            startCoordinate = nil
//        }
//    }
//    
//    @State var isShowingSearchList = false
//    @State private var searchResults: [Place] = []
//    @State private var currentSearchType: SearchType? = nil
//    
//    var body: some View {
//        VStack {
//            VStack(spacing: 13) {
//                SearchRow(label: "출발", textFieldLabel: "출발지 입력", text: $startPointSearch, isCurrentLocation: true, onTapCurrentLocation: {fetchCurrentLocationAddress()}, isShowingSearchList: $isShowingSearchList, searchKeyword: { keyword in
//                    currentSearchType = .start
//                    KakaoLocalSearchService.search(keyword: keyword) { results in
//                        if results.isEmpty {
//                            isShowingNoneResultAlert = true
//                        } else {
//                            searchResults = results
//                        }
//                    }
//                })
//                
//                SearchRow(label: "도착", textFieldLabel: "도착지 입력", text: $endPointSearch, isShowingSearchList: $isShowingSearchList, searchKeyword: { keyword in
//                    currentSearchType = .end
//                    let results = StoreDataLoader.loadFilteredStores(matching: keyword)
//                    searchResults = results
//                    isShowingSearchList = true
//                    if results.isEmpty {
//                        isShowingNoneResultAlert = true
//                    }
//                })
//                .padding(.bottom, 5)
//                
//                Button(action: {
//                    let start = startCoordinate ?? Coordinate(lon: 126.9784, lat: 37.5666)
//                    
//                    let end = endCoordinate ?? Coordinate(lon: 127.0276, lat: 37.4979)
//                    
//                    viewModel.fetchRoute(from: start, to: end)
//                }, label: {
//                    GreenButton(title: "경로 찾기")
//                })
//                .frame(height: 38)
//            }
//            .padding(.horizontal, 20)
//            
//            // 검색어 리스트
//            if !searchResults.isEmpty {
//                ScrollView {
//                    LazyVStack(spacing: 0) {
//                        ForEach(searchResults) { place in
//                            HStack {
//                                VStack(alignment: .leading, spacing: 8) {
//                                    Text(place.place_name)
//                                        .font(.mainTextMedium16())
//                                    Text(place.address_name)
//                                        .font(.mainTextMedium13())
//                                        .foregroundColor(.gray)
//                                }
//                                .padding(16)
//                                .onTapGesture {
//                                    switch currentSearchType {
//                                    case .start:
//                                        startPointSearch = place.place_name
//                                        updateStartCoordinate(from: place)
//                                        
//                                        if let xStr = place.x, let yStr = place.y,
//                                                   let lon = Double(xStr), let lat = Double(yStr) {
//                                                    startCoordinate = Coordinate(lon: lon, lat: lat)
//                                                }
//                                        
//                                    case .end:
//                                        searchResults = []
//                                        endPointSearch = place.place_name
//                                        if let coords = StoreDataLoader.geoStoreCoordinate(for: place.place_name) {
//                                            endCoordinate = Coordinate(lon: coords.x, lat: coords.y)
//                                        }
//                                    case nil:
//                                        break
//                                    }
//                                    searchResults = []
//                                }
//                                Spacer()
//                            }
//                            Divider()
//                                .frame(height: 1)
//                                .background(Color("gray01"))
//                        }
//                    }
//                }
//            }
//            
//            // 결과 화면
//            if let route = viewModel.routeData?.routes.first {
//                let coordinates = route.geometry.coordinates.map {
//                    CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
//                }
//                RouteMapView(coordinates: coordinates)
//            } else {
//                RouteMapView(coordinates: [])
//            }
//            
//        }// 최상단 vstack
//        .onAppear {
//            locationDelegate.onAuthUpdate = { status in
//                isAuthorized = status == .authorizedWhenInUse || status == .authorizedAlways
//            }
//            locationManager.delegate = locationDelegate
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//}
//
//struct SearchRow: View {
//    let label: String
//    let textFieldLabel: String
//    @Binding var text: String
//    
//    var isCurrentLocation: Bool = false
//    var onTapCurrentLocation: (() -> Void)? = nil
//    
//    @Binding var isShowingSearchList: Bool
//    var searchKeyword: ((String) -> Void)? = nil
//
//    var body: some View {
//        HStack {
//            Text(label)
//            
//            if isCurrentLocation {
//                Button {
//                    onTapCurrentLocation?()
//                } label: {
//                    Text("현재위치")
//                        .foregroundStyle(Color.white)
//                        .padding(6)
//                        .background(Color("brown01"))
//                        .clipShape(RoundedRectangle(cornerRadius: 6))
//                }
//            }
//            
//            ZStack {
//                Rectangle()
//                    .frame(height: 30)
//                    .foregroundStyle(Color.clear)
//                    .border(Color("gray01"), width: 1)
//                
//                TextField(textFieldLabel, text: $text)
//                    .padding(5)
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.5)
//            }
//            
//            Button {
//                isShowingSearchList = true
//                searchKeyword?(text)
//            } label: {
//                Image(systemName: "magnifyingglass")
//                    .foregroundStyle(Color.black)
//            }
//        }
//    }
//}
//
//class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
//    var onUpdate: (CLLocation) -> Void
//    var onAuthUpdate: ((CLAuthorizationStatus) -> Void)?
//
//    init(onUpdate: @escaping (CLLocation) -> Void) {
//        self.onUpdate = onUpdate
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        let status = manager.authorizationStatus
//        onAuthUpdate?(status)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            onUpdate(location)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("위치 가져오기 실패: \(error)")
//    }
//}
//
//struct FeatureCollection: Decodable {
//    let features: [Feature]
//}
//
//struct Feature: Decodable {
//    let properties: Properties
//}
//
//struct Properties: Decodable {
//    let storeName: String
//    let address: String
//    let Xcoordinate: Double
//    let Ycoordinate: Double
//
//    enum CodingKeys: String, CodingKey {
//        case storeName = "Sotre_nm"
//        case address = "Address"
//        case Xcoordinate = "Xcoordinate"
//        case Ycoordinate = "Ycoordinate"
//    }
//}
//
//class StoreDataLoader {
//    static func loadFilteredStores(matching keyword: String) -> [Place] {
//        guard let url = Bundle.main.url(forResource: "data", withExtension: "geojson"),
//              let data = try? Data(contentsOf: url),
//              let featureCollection = try? JSONDecoder().decode(FeatureCollection.self, from: data) else {
//            return []
//        }
//
//        let trimmedKeyword = keyword.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//
//        let filtered = featureCollection.features.filter {
//            $0.properties.storeName.lowercased().contains(trimmedKeyword) ||
//            $0.properties.address.lowercased().contains(trimmedKeyword)
//        }
//        print("🔍 검색된 매장 수: \(filtered.count)")
//        filtered.forEach {
//            print("• \($0.properties.storeName) | \($0.properties.address)")
//        }
//
//        return filtered.map {
//            Place(id: UUID().uuidString, place_name: $0.properties.storeName, address_name: $0.properties.address)
//        }
//    }
//
//    static func geoStoreCoordinate(for storeName: String) -> (x: Double, y: Double)? {
//        guard let url = Bundle.main.url(forResource: "data", withExtension: "geojson"),
//              let data = try? Data(contentsOf: url),
//              let featureCollection = try? JSONDecoder().decode(FeatureCollection.self, from: data) else {
//            return nil
//        }
//        if let feature = featureCollection.features.first(where: { $0.properties.storeName == storeName }) {
//            return (x: feature.properties.Xcoordinate, y: feature.properties.Ycoordinate)
//        }
//        return nil
//    }
//}
//
//#Preview {
//    FindMapVIewClone(
//        isShowingNoneResultAlert: .constant(false),
//        viewModel: RouteViewModel()
//    )
//}

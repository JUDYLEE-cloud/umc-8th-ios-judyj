import SwiftUI
import MapKit
import Observation

@Observable
final class SearchViewModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var currentMapCenter: CLLocationCoordinate2D?
    
    struct Place: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
        let address: String?
        let mapItem: MKMapItem

        init(mapItem: MKMapItem) {
            self.name = mapItem.name ?? "Unknown Place"
            self.coordinate = mapItem.placemark.coordinate
            self.address = mapItem.placemark.title
            self.mapItem = mapItem
        }
    }
    var searchResults: [Place] = []
    
    var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    
    // 마커
    struct SearchCustomMarker: Identifiable {
        let id = UUID()
        let title: String
        let coordinate: CLLocationCoordinate2D
        
        init(_ title: String, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.coordinate = coordinate
        }
    }
    
    var makers: [SearchCustomMarker] = [
        .init("중앙대학교", coordinate: .init(latitude: 37.504675, longitude: 126.957034)),
        .init("용산 CGV", coordinate: .init(latitude: 37.529598, longitude: 126.963946))
    ]

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010) // 본인의 학교 위도 / 경도로 넣어보세요
    let geofenceRadius: CLLocationDistance = 200
    let geofenceIdentifier = "포항공대"
    
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
    
    func search(query: String, to locaation: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = .init(center: locaation.coordinate, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self, let mapItems = response?.mapItems else { return }
            
            DispatchQueue.main.async {
                self.searchResults = mapItems.map { Place(mapItem: $0) }
            }
        }
    }
}

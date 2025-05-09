import Foundation
import SwiftUI
import MapKit
import Observation

@Observable
final class SearchMapViewModel {
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
    
    func setInitialCameraPosition(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: location,
            span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09) // 대략 10km
        )
        self.cameraPosition = .region(region)
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
    
    func updateFromLocation(_ location: CLLocation?) {
        guard let location = location else { return }
        // 사용자의 위치를 기준으로 지도 중심을 업데이트
        cameraPosition = .region(MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)
        ))
    }

}

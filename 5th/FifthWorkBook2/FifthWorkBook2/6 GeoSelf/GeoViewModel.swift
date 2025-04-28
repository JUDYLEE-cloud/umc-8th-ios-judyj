import Foundation
import SwiftUI
import MapKit
import Observation
import Combine

// @Observable
final class GeoViewModel: ObservableObject {
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var currentMapCenter: CLLocationCoordinate2D?
    @Published var currentAddress: String?
    
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
    @Published var searchResults: [Place] = []
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010)
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
    
    func geocodeAddress(_ address: String) async {
        do {
            let coordinate = try await LocationManager.shared.geocode(address: address)
            DispatchQueue.main.async {
                self.currentMapCenter = coordinate
                self.cameraPosition = .region(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
            }
        } catch {
            print("지오코딩 실패: \(error.localizedDescription)")
        }
    }
    
    func reverseGeocodeLocation(_ location: CLLocation) async {
        do {
            let address = try await LocationManager.shared.reverseGeocode(location: location)
            DispatchQueue.main.async {
                self.currentAddress = address
            }
        } catch {
            print("역지오코딩 실패: \(error.localizedDescription)")
        }
    }
    
    func updateCurrentCenter(_ center: CLLocationCoordinate2D) async {
        DispatchQueue.main.async {
            self.currentMapCenter = center
        }
    }

    func updateCurrentAddress() async {
        guard let center = currentMapCenter else { return }
        let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
        await reverseGeocodeLocation(location)
    }
    
}

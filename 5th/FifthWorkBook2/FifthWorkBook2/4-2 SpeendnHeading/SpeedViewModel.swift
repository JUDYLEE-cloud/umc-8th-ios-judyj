import SwiftUI
import MapKit
import Observation

@Observable
final class SpeedViewModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var didEnterGeofence: Bool = false
    
    func setInitialCameraPosition(location: CLLocationCoordinate2D) {
            let region = MKCoordinateRegion(
                center: location,
                span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09) // 대략 10km
            )
            self.cameraPosition = .region(region)
        }
    
    // 마커
    struct CustomMarker: Identifiable {
        let id = UUID()
        let title: String
        let coordinate: CLLocationCoordinate2D
        
        init(_ title: String, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.coordinate = coordinate
        }
    }
    var makers: [CustomMarker] = [
        .init("중앙대학교", coordinate: .init(latitude: 37.504675, longitude: 126.957034)),
        .init("용산 CGV", coordinate: .init(latitude: 37.529598, longitude: 126.963946))
    ]

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010) // 본인의 학교 위도 / 경도로 넣어보세요
    let geofenceRadius: CLLocationDistance = 100
    let geofenceIdentifier = "포항공대"
    
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
}

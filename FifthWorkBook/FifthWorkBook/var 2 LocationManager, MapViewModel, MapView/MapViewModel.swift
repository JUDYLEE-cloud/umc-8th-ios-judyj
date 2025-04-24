import Foundation
import SwiftUI
import MapKit
import Observation

@Observable
final class MapViewModel {
    // MapCameraPosition: 지도 카메라 위치를 특정 좌표로 이동시키는 핵심 메서드.
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var currentMapCenter: CLLocationCoordinate2D?
    
    var markers: [Marker] = [
        // coordinate: 좌표. 위도, 경도로 구성됨
        .init(coordinate: .init(latitude: 37.562741, longitude: 126.946782), title: "이화여자대학교"),
        .init(coordinate: .init(latitude: 36.014927, longitude: 129.323055), title: "포항공과대학교"
             )
    ]
    
    // 챗지피티
    func updateFromLocation(_ location: CLLocation?) {
        guard let location = location else { return }
        // 예시: 사용자의 위치를 기준으로 지도 중심을 업데이트
        cameraPosition = .region(MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
}

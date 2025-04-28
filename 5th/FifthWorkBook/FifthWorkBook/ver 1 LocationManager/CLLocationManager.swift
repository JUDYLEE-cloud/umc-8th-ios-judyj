// 위치 권한 요청하는 조수 역할
import Foundation
import MapKit

// viewmodel 또는 observable로 관리
// observable로 정의한 클래스의 속성이 바뀌면, ui도 자동으로 반응함
@Observable
//NSObject, CLLocationManagerDelegate: 위치 업데이트를 받기 위한 공식 위임 클래스
class LocationManager1: NSObject, CLLocationManagerDelegate {
    // 실제로 위치를 추적해주는 조수/매니절~
    private let manager = CLLocationManager()
    
    // 지도에 보여줄 기본 위치 (위도 0 경도 0 아프리카 바다 한가운데)
    var region = MKCoordinateRegion (
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // 초기 설정
    override init() {
        super.init()
        // 내가 위치 정보를 받을게요!라고 선언
        manager.delegate = self
        // 가장 정확한 위치
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // 앱을 실행중일 때만 위치 권한 요청.
        manager.requestWhenInUseAuthorization()
        // 위치 추적 시작
        manager.startUpdatingLocation()
    }
    
    // 위치가 변경되면 이 함수 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 가장 최근 위치 하나만 가져옴
        guard let location = locations.first else {return}
        
        // ui 업데이트
        // 지도 중심을 현재 위치로 이동시킴
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
        print(location.coordinate)
    }
}

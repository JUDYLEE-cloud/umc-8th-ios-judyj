import Foundation
import CoreLocation
import MapKit
import Observation

@Observable
class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    // MARK: - CLLocationManager
    private let locationManager = CLLocationManager()
    
    // MARK: - Published Properties
    var currentLocation: CLLocation?
    var currentHeading: CLHeading?
    
    var currentSpeed: CLLocationSpeed = 0
    var currentDirection: CLLocationDirection = 0
    
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    var didEnterGeofence: Bool = false
    
    // MARK: - Init
    override init() {
        super.init()
        
        // 위치 정보나 방향이 바뀔 때 자신한테 알려달라는 의미
        locationManager.delegate = self
        // 위치 정보의 정확도 수준 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 나침반 업데이트 민감도 설정
        locationManager.headingFilter = kCLHeadingFilterNone
        
        requestAuthorization()
        startUpdatingLocation()
        startUpdatingHeading()
        
    }
    
    // MARK: - 권한 요청
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
    }

    // MARK: - 실시간 위치 추적 시작
    func startUpdatingLocation() {
        // 주기적으로 호출됨 + 위치 변경이 감지되면 자동으로 알려줌
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - 나침반 방향 추적, 정보 수신 시작
    func startUpdatingHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func stopUpdatingHeading() {
        locationManager.stopUpdatingHeading()
    }

    // MARK: - Significant Location Change
    func startMonitoringSignificantLocationChanges() {
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopMonitoringSignificantLocationChanges() {
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    // MARK: - 방문 감지
    func startMonitoringVisits() {
        locationManager.startMonitoringVisits()
    }

    // MARK: - 지오펜싱
    func startMonitoringGeofence(center: CLLocationCoordinate2D,
                                 radius: CLLocationDistance,
                                 identifier: String) {
        let region = CLCircularRegion(center: center,
                                      radius: radius,
                                      identifier: identifier)
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        locationManager.startMonitoring(for: region)
    }

    func stopMonitoringAllGeofences() {
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // 권한 변경 감지
    // 사용자가 위치 권한을 승인/거부하거나, 설정을 변경했을 때 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    // 위치 업데이트 감지 (기본 위치 추적 + Significant Change)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latest = locations.last {
            DispatchQueue.main.async {
                self.currentLocation = latest
                self.currentSpeed = max(latest.speed, 0)
            }
        }
    }

    // 방향 감지. 나침반의 방향이 바뀔 때마다 호출
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.currentHeading = newHeading
            self.currentDirection = newHeading.trueHeading > 0 ? newHeading.trueHeading : newHeading.magneticHeading
        }
    }

    // 방문 감지. 특정 장소에 도착해서 머무른 시간이 수 분 이상이고, 이동이 명확하게 감지될 경우 호출
    // ios 시스템이 자동으로 의미 있는 장소를 인식해서 감지
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("방문 감지됨 - 좌표: \(visit.coordinate), 도착: \(visit.arrivalDate), 출발: \(visit.departureDate)")
    }

    // 지오펜싱: 진입. 사용자가 지정한 영역 안으로 들어갔을 때.
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = true
        }
    }

    // 지오펜싱: 이탈. 사용자가 지정한 영역 밖으로 나갔을 때
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        DispatchQueue.main.async {
            self.didEnterGeofence = false
        }
    }

    // 오류 처리. 위치 정보 요청 중.문제가 발생될 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 오류: \(error.localizedDescription)")
    }
}

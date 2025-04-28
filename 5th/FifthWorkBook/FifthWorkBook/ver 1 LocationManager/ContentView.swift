import SwiftUI
import MapKit // map kit 임포트

struct ContentView: View {
    // MKCoordinateRegion: 카메라 뷰포트. 지도의 표시 영역 설정
    // center - latitude 위도, longitude 경도
    // span - 지도의 확대 정도(줌 레벨) 지정. 숫자가 작을수록 더 확대된 지도
    // @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    private var locationManager = LocationManager1()
    
    var body: some View {
        Map(initialPosition: .region(locationManager.region))
        // 초기 지도 위치만 정해주라는 뜻. 즉, 초기엔 잘 나올 수 있지만 위치 값이 바뀌어도 지도는 가만히 있음.
        // 즉, 실제 지도 기능에서 다루는데 적합하지 않음!
    }
}

#Preview {
    ContentView()
}

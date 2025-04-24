import SwiftUI
import MapKit

struct MapView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    // private let locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    @Namespace var mapScope
    
    var body: some View {
        ZStack(alignment: .bottomTrailing, content: {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                ForEach(viewModel.markers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(systemName: "mappin.circle.fill")
                            .renderingMode(.template) // 원래 색을 무시하고 설정한 색으로 이미지를 채움
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    })
                })
                
                UserAnnotation(anchor: .center)
            }
            
            MapUserLocationButton(scope: mapScope)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                        .stroke(Color.red, style: .init(lineWidth: 2))
                })
                .offset(x: -10, y: -10)
        })
        .mapScope(mapScope)
//        .task {
//            viewModel.updateFromLocation(locationManager.currentLocation)
//        }
    }
}

#Preview {
    MapView()
}

import SwiftUI
import MapKit

struct SpeedView: View {
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: SpeedViewModel = .init()
    
    @State private var lastKnownLocation: CLLocationCoordinate2D?
    @State private var showSearchButton: Bool = false
    
    @Namespace var mapScope
    
    @State private var showEnteredAlert: Bool = false
    @State private var showExitedAlert: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                ForEach($viewModel.makers, id: \.id) { $marker in
                    Annotation(marker.title, coordinate: marker.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(Color.red)
                    }
                }
                
                UserAnnotation()
                
                MapCircle(center: viewModel.geofenceCoordinate, radius: viewModel.geofenceRadius)
                    .foregroundStyle(Color.blue.opacity(0.2))
                    .stroke(Color.blue, lineWidth: 2)
            }
            .onChange(of: locationManager.didEnterGeofence) { _, entered in
                if entered {
                    showEnteredAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showEnteredAlert = false
                        locationManager.didEnterGeofence = false
                    }
                }
            }

            .onChange(of: locationManager.didExitGeofence) { _, exited in
                if exited {
                    showExitedAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showExitedAlert = false
                        locationManager.didExitGeofence = false
                    }
                }
            }
            
            MapUserLocationButton(scope: mapScope)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.clear)
                        .stroke(Color.red, style: .init(lineWidth: 2))
                })
                .offset(x: -10, y: -10)
            
            if showEnteredAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 진입함")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }

            if showExitedAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 벗어남")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }
        }
        .mapScope(mapScope)
        .overlay(alignment: .top, content: {
            VStack(content: {
                HStack(spacing: 10) {
                    Text("속도: \(locationManager.currentSpeed, specifier: "%.2f") m/s")
                    
                    Text("방향: \(locationManager.currentDirection, specifier: "%.0f")°")
                }
            })
        })
        .onAppear {
            if let userLocation = locationManager.currentLocation?.coordinate {
                viewModel.setInitialCameraPosition(location: userLocation)
            }
        }
    }
}

#Preview {
    SpeedView()
}

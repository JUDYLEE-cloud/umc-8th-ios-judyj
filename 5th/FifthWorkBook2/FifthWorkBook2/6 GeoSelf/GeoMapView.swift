import SwiftUI
import MapKit
import CoreLocation

struct GeoMapView: View {
    @StateObject private var viewModel = GeoViewModel()
    @State private var addressInput: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            HStack {
                TextField("주소를 입력하세요", text: $addressInput)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                
                Button("검색") {
                    Task {
                        await viewModel.geocodeAddress(addressInput)
                        isTextFieldFocused = false
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()

            Map(position: $viewModel.cameraPosition) {
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
            }
            .frame(height: 300)
            .cornerRadius(12)
            .padding()
            .onMapCameraChange { context in
                let center = context.region.center
                Task {
                    await viewModel.updateCurrentCenter(center)
                    await viewModel.updateCurrentAddress()
                }
            }

            if let address = viewModel.currentAddress {
                Text("현재 중심 주소: \(address)")
                    .font(.subheadline)
                    .padding()
            }

            Spacer()
        }
        .task {
            if let center = viewModel.currentMapCenter {
                await viewModel.reverseGeocodeLocation(CLLocation(latitude: center.latitude, longitude: center.longitude))
            }
        }
    }
}

#Preview {
    GeoMapView()
}

//
//  MapResultView.swift
//  StarbucksCloneTuist
//
//  Created by 이주현 on 5/28/25.
//

import SwiftUI
import CoreLocation

struct MapResultView: View {
    @ObservedObject var viewModel: RouteViewModel
    
    var body: some View {
        if let route = viewModel.routeData?.routes.first {
            let coordinates = route.geometry.coordinates.map {
                CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
            }
            RouteMapView(coordinates: coordinates)
        } else {
            RouteMapView(coordinates: [])
        }
    }
}

#Preview {
    MapResultView(viewModel: RouteViewModel())
}

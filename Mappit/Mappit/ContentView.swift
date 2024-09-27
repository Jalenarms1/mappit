//
//  ContentView.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var mapType: MKMapType = .hybrid
    
    @StateObject private var locationManager = LocationManager()
    @State var annotations: [MKPointAnnotation] = []
    
    @StateObject private var srManager = SRViewModel(serviceRequests: sampleServiceRequests)
    
    init(){
        print(srManager.serviceRequests)
    }

    var body: some View {
        ZStack {
            Map(position: $locationManager.camera) {
                UserAnnotation()
                if let latitude = locationManager.camera.region?.center.latitude,
                   let longitude = locationManager.camera.region?.center.longitude {
                    Marker(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)) {
                        Label("Test", systemImage: "globe")
                    }
                    .tint(.yellow)
                    
                    
                }
            }
            .ignoresSafeArea([])
            .mapControls {
                MapUserLocationButton()
            }
            
        }
            
            
    }
    
    
}



#Preview {
    ContentView()
}

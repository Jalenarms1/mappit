//
//  ContentView.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI
import MapKit

@MainActor
struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @StateObject private var serviceRequestVM = ServiceRequestVM(serviceRequests: sampleServiceRequests)
    
    
    var body: some View {
        ZStack {
            Map(position: $locationManager.camera, interactionModes: .all) {
                UserAnnotation()
                ForEach(serviceRequestVM.serviceRequests, id: \.id) {r in
                    if let coordinate = r.coordinate {
                        
                        Marker(coordinate: coordinate) {
                            Label(r.urgency.rawValue, systemImage: "globe")
                        }
                        .tint(.yellow)
                        
                    }
                }
            }
            .ignoresSafeArea([])
            .mapControls {
                MapUserLocationButton()
                MapPitchToggle()
                
            }
            .onAppear {
                Task {
                    await serviceRequestVM.loadCoordinates()
                }
            }
        }
            
            
    }
    
    
}



#Preview {
    MapView()

}

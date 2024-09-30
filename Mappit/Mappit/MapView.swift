//
//  ContentView.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @ObservedObject private var serviceRequestVM = ServiceRequestVM(serviceRequests: sampleServiceRequests)
    
    
    var body: some View {
        ZStack {
            Map(position: $locationManager.camera, interactionModes: .all) {
                UserAnnotation()
                
                ForEach(serviceRequestVM.serviceRequests, id: \.id) {r in
                    if let coordinate = r.coordinate {
                        
                        Annotation("", coordinate: coordinate) {
                            SRAnnotation(urgencyLevel: r.urgency)
                        }
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
            
            SRQueueView(serviceRequests: serviceRequestVM.serviceRequests)
        }
    }
}

#Preview {
    MapView()
}

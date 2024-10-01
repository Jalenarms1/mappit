//
//  ContentView.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var locationManager = LocationManager()
    
    @ObservedObject private var serviceRequestVM = ServiceRequestVM(serviceRequests: sampleServiceRequests)
    
    
   
    
    var body: some View {
        ZStack {
            Map(position: $locationManager.camera, interactionModes: .all) {
                UserAnnotation()
                
                ForEach(serviceRequestVM.serviceRequestList, id: \.id) {r in
                    if let coordinate = r.coordinate {
                        
                        Annotation(r.address, coordinate: coordinate) {
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
            .sheet(isPresented: $serviceRequestVM.showSRSheet) {
                if let sr = serviceRequestVM.selectedSR {
                    SRSheet(serviceReq: sr, showSRSheet: $serviceRequestVM.showSRSheet)
                        .presentationDetents([.height(300)])
                }
            }
            
            
//            SRQueueView(serviceRequests: serviceRequestVM.serviceRequestList)
            
            srSearchView
        }
    }
    
    
    private var srSearchView: some View {
        VStack {
            Spacer()
            
            VStack {
                TextField("Search for a property address 🔍", text: $serviceRequestVM.srSearchTerm)
                    .padding()
                    .background(Color(.lightGray).opacity(0.25))
                    .cornerRadius(5)
                    .onSubmit {
                        serviceRequestVM.srSearchTerm = ""
                    }
                
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(serviceRequestVM.serviceRequestList) { r in
                            VStack {
                                HStack {
                                    Image(systemName: r.urgency.urgencyImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(4)
                                        .background(Color(r.urgency.urgencyColor))
                                        .foregroundStyle(Color.white)
                                        .clipShape(.circle)
                                    
                                    Text(r.address)
                                        .font(.system(size: 14, weight: .semibold))
                                }
                            }
                                .padding()
                                .onLongPressGesture(minimumDuration: 0.3) {
                                    guard let coordinate = r.coordinate else { return }
                                    
                                    locationManager.updLocation(to: coordinate)
                                    
                                    serviceRequestVM.selectedSR = r
                            }
                        }
                        
                    }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                Spacer()
            }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.white.opacity(0.98))
            
            
            
        }
        .ignoresSafeArea()
        
        
        
    }
}

enum AppError: Error {
    case runtimeErr(String)
}

#Preview {
    MapView()
}

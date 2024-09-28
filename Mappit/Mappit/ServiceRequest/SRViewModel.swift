//
//  ViewModel.swift
//  Mappit
//
//  Created by Jalen Arms on 9/27/24.
//

import SwiftUI
import CoreLocation

class ServiceRequestVM: ObservableObject {
    @Published var serviceRequests: [ServiceRequest] = []
    
    init(serviceRequests: [ServiceRequest]){
        self.serviceRequests = serviceRequests

    }
    
    
    func loadCoordinates() async {
        for i in serviceRequests.indices {
            if serviceRequests[i].coordinate == nil {
                let coord = await serviceRequests[i].getAddrCoordinates()
                
                DispatchQueue.main.async {
                    self.serviceRequests[i].coordinate = coord
                    
                }
                
            }
            
        }
            
        
    }
    
    
    
}


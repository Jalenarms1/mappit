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
        self.serviceRequests = serviceRequests.sorted { (a: ServiceRequest, b: ServiceRequest) -> Bool in
            let urgencyLevel1 = a.urgency == .high ? 1 : a.urgency == .moderate ? 2 : 3
            let urgencyLevel2 = b.urgency == .high ? 1 : b.urgency == .moderate ? 2 : 3
            
            return urgencyLevel1 < urgencyLevel2
        }

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


//
//  ViewModel.swift
//  Mappit
//
//  Created by Jalen Arms on 9/27/24.
//

import SwiftUI

class ServiceRequestVM: ObservableObject {
    var serviceRequests: [ServiceRequest] = []
    
    init(serviceRequests: [ServiceRequest]){
        
        self.serviceRequests = serviceRequests
    }
}


//
//  ViewModel.swift
//  Mappit
//
//  Created by Jalen Arms on 9/27/24.
//

import SwiftUI
import CoreLocation

final class ServiceRequestVM: ObservableObject {
    var serviceRequests: [ServiceRequest] = [] {
        didSet {
            if !loadingCoordinates {
                self.serviceRequestList = self.serviceRequests
            }
        }
    }
    
    @Published var srSearchTerm: String = "" {
        didSet {
            filterSRList()
        }
    }
//    used for final view list after any user filters
    @Published var serviceRequestList: [ServiceRequest] = []
    
    @Published var selectedSR: ServiceRequest? = nil {
        didSet {
            self.showSRSheet = true
            
        }
    }
    
    @Published var showSRSheet: Bool = false
    
    private var loadingCoordinates: Bool = false
    
    
    init(serviceRequests: [ServiceRequest]){
        self.serviceRequests = serviceRequests.sorted { (a: ServiceRequest, b: ServiceRequest) -> Bool in
            let urgencyLevel1 = a.urgency == .high ? 1 : a.urgency == .moderate ? 2 : 3
            let urgencyLevel2 = b.urgency == .high ? 1 : b.urgency == .moderate ? 2 : 3
            
            return urgencyLevel1 < urgencyLevel2
        }
        
        
        
    }
    
    
    func loadCoordinates() async {
        self.loadingCoordinates = true
        for i in serviceRequests.indices {
            if serviceRequests[i].coordinate == nil {
                let coord = await serviceRequests[i].getAddrCoordinates()
                
                if i == serviceRequests.count - 1 {
                    self.loadingCoordinates = false
                }
                
                DispatchQueue.main.async {
                    self.serviceRequests[i].coordinate = coord
                }
            }
            
        }
    }
    
    private func filterSRList() {
        if srSearchTerm == "" {
            self.serviceRequestList = self.serviceRequests
            return
        } else {
            self.serviceRequestList = self.serviceRequests.filter { $0.address.localizedCaseInsensitiveContains(self.srSearchTerm) }
            
        }
    }
}


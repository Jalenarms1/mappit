//
//  Model.swift
//  Mappit
//
//  Created by Jalen Arms on 9/27/24.
//
import SwiftUI
import CoreLocation

struct ServiceRequest: Identifiable {
    var id: String
    var urgency: SRUrgency
    var createdAt: Date
    var status: SRStatus
    var address: String
    var coordinate: CLLocationCoordinate2D?
    
    func getAddrCoordinates() async -> CLLocationCoordinate2D {
        let geocoder = CLGeocoder()
        
        let coordinates = try? await geocoder.geocodeAddressString(self.address).first?.location
        
        
        return CLLocationCoordinate2D(latitude: coordinates!.coordinate.latitude, longitude: coordinates!.coordinate.longitude)
    }
}

enum SRUrgency: String {
    case high = "High"
    case moderate  = "Moderate"
    case low = "Low"
    
    var urgencyImage: String {
        switch self {
        case .high:
            return "exclamationmark.triangle"
        case .moderate:
            return "hammer.circle.fill"
        case .low:
            return "hammer.circle"
        }
        
    }
    
    var urgencyColor: Color {
        switch self {
        case .high:
            return .red
        case .moderate:
            return .yellow
        case .low:
            return .green
        }
    }
    
    
}

enum SRStatus: String {
    case waiting = "Waiting"
    case enroute = "En Route"
    case fulfilled = "Fulfilled"
    case unresolved  = "Unresolved"
}

let sampleServiceRequests: [ServiceRequest] = [
    ServiceRequest(id: "2", urgency: .moderate, createdAt: Date().addingTimeInterval(-3600), status: .enroute, address: "849 Howard St San Fransisco, CA 94103"),
    ServiceRequest(id: "1", urgency: .high, createdAt: Date(), status: .waiting, address: "869 Folsom St San Fransisco, CA 94103"),
    ServiceRequest(id: "3", urgency: .low, createdAt: Date().addingTimeInterval(-7200), status: .fulfilled, address: "825 Parnell Pl Sunnyvale, CA 94087"),
    ServiceRequest(id: "4", urgency: .high, createdAt: Date().addingTimeInterval(-1800), status: .unresolved, address: "1790 Lark ln Sunnyvale, CA 94087"),
    ServiceRequest(id: "5", urgency: .moderate, createdAt: Date().addingTimeInterval(-5400), status: .waiting, address: "619 Meadow Ave Santa Clara, CA 95051"),
]


//
//  Model.swift
//  Mappit
//
//  Created by Jalen Arms on 9/27/24.
//
import SwiftUI

struct ServiceRequest {
    var id: String
    var urgency: SRUrgency
    var createdAt: Date
    var status: SRStatus
    var address: String
}

enum SRUrgency: String {
    case high = "High"
    case moderate  = "Moderate"
    case low = "Low"
}

enum SRStatus: String {
    case waiting = "Waiting"
    case enroute = "En Route"
    case fulfilled = "Fulfilled"
    case unresolved  = "Unresolved"
}

let sampleServiceRequests: [ServiceRequest] = [
    ServiceRequest(id: "1", urgency: .high, createdAt: Date(), status: .waiting, address: "123 Main St, Springfield, IL 62701"),
    ServiceRequest(id: "2", urgency: .moderate, createdAt: Date().addingTimeInterval(-3600), status: .enroute, address: "456 Elm St, Springfield, IL 62701"),
    ServiceRequest(id: "3", urgency: .low, createdAt: Date().addingTimeInterval(-7200), status: .fulfilled, address: "789 Oak St, Springfield, IL 62701"),
    ServiceRequest(id: "4", urgency: .high, createdAt: Date().addingTimeInterval(-1800), status: .unresolved, address: "321 Pine St, Springfield, IL 62701"),
    ServiceRequest(id: "5", urgency: .moderate, createdAt: Date().addingTimeInterval(-5400), status: .waiting, address: "654 Maple Ave, Springfield, IL 62701"),
]


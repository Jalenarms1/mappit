//
//  LocationManager.swift
//  Mappit
//
//  Created by Jalen Arms on 9/26/24.
//

import SwiftUI
import MapKit
import CoreLocation

let defRegion = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
)

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, MKMapViewDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    @Published var region = defRegion
    @Published var camera = MapCameraPosition.region(defRegion)
    @Published var annotationTitle = ""
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate method to update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Update the region with the user's current location
        self.region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        self.camera = MapCameraPosition.region(self.region)
    }
    
    func requestLocationAuthorization() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    // Handle authorization status changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
        case .notDetermined, .restricted, .denied:
            print("Location access denied.")
        default:
            break
        }
    }
    
    func getCoordinatesLabel(pinLocation: CLLocationCoordinate2D) async -> String {
        annotationTitle = ""
        
        let location = CLLocation(latitude: pinLocation.latitude, longitude: pinLocation.longitude)
        
        let geocoder = CLGeocoder()
        
        if let name = try? await geocoder.reverseGeocodeLocation(location).first?.name {
            annotationTitle = name
        }
        
        return annotationTitle == "" ? "No address found" : annotationTitle
        
    }
}



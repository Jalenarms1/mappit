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
    center: CLLocationCoordinate2D(latitude: 33.4484, longitude: 112.0740),
//    calculation for tap coordinates wasn't working due to this span not being used as bounds for map
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
)

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: defRegion.center.latitude, longitude: defRegion.center.longitude)
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.coordinate = location.coordinate
        
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
    
    func updLocation(to coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        self.camera = MapCameraPosition.region(self.region)
    }
    
    
}



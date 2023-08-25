//
//  LocationServicesVC.swift
//  Bilge_Adam_Sample
//
//  Created by İsmail Caferoğlu on 17.08.2023.
//

import UIKit
import CoreLocation

class LocationServicesVC: UIViewController,CLLocationManagerDelegate {
    


    private lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.requestWhenInUseAuthorization()
        return location
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.33114614, longitude: -122.03071071), radius: 500, identifier: "BilgeAdam")
        
        locationManager.startMonitoring(for: region)
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        print("Bölgemize hoşgeldiniz\(region.identifier)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if let location = locations.last {
            
            print(location.coordinate.longitude)
            print(location.coordinate.latitude)
        }
        

        }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }

    
}

/*
 ITS manages all the location stuff
 */

import Foundation
import CoreLocation



class LocationManager: NSObject , ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    @Published var location = CLLocationCoordinate2D?(.init())
    @Published var isloading = false
    
    override init()
    {
        super.init()
        manager.delegate = self
    }
    func requestLoaction(){
        isloading = true
        manager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            location = firstLocation.coordinate
                    isloading = false
                }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error Getting Location", error)
         isloading = false
    }
    
}

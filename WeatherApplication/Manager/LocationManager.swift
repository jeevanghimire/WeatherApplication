/*
 ITS manages all the location stuff
 */

import Foundation
import CoreLocation



class LocationManager: NSObject , ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location = CLLocationCoordinate2D()
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
        guard let location = locations.first?.coordinate else{
            return print(Error.self);
        }
        isloading = false
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Error Getting Location", error)
         isloading = false
    }
    
}

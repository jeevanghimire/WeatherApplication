//
//  WeatherApplicationApp.swift
//  WeatherApplication
//
//  Created by Jeevan Ghimire on 8/28/24.
//

import SwiftUI
import CoreLocation

@main
struct WeatherApplicationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocationManager())
        }
    }
}

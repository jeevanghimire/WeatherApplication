//
//  WelcomeView.swift
//  WeatherApplication
//
//  Created by Jeevan Ghimire on 8/28/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager:LocationManager
    
    
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                Text("Welcom to the Weather App")
                    .bold().font(.title)
                Text("Please share your location to get started with the application")
                    .padding()
                
            }.multilineTextAlignment(.center)
                .padding()
            
            
            LocationButton(.shareCurrentLocation){
                locationManager.requestLoaction()
            }.cornerRadius(30).symbolVariant(.fill).foregroundColor(.white)
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
    }
}

#Preview {
    WelcomeView()
        .environmentObject(LocationManager())  // Provide a LocationManager instance
    
}

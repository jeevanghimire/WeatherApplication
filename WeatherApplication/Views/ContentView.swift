//
//  ContentView.swift
//  WeatherApplication
//
//  Created by Jeevan Ghimire on 8/28/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather:ResponseBody?
    var body: some View {
        VStack{
            if let location = locationManager.location{
                if weather == nil{
                    WeatherView(weather:previewWeather)
//                    WelcomeView()
                }else{
                    LoadingView()
                        .task{
                            do{
                                try await weather = weatherManager.getCurrentWeather(latitude:location.latitude,longitude: location.longitude)
                                Task{
                                    do {
                                            let weatherData = try await weatherManager.getCurrentWeather(latitude: 28.6139, longitude: 77.2090)
                                            
                                            // Save the weather data to "WeatherData.json"
                                            weatherManager.saveWeatherData(weatherData, to: "WeatherApplication/WeatherData.json")
                                        } catch {
                                            print("Error fetching weather data: \(error)")
                                        }
                                }
                            }
                            catch{
                                print("Error Getting Weather \(error)")
                            }
                        }
                }
            }
            
            else{
                if locationManager.isloading
                {
                    LoadingView()
                }
                else {
                    WelcomeView()
                        .padding()
                        .background(Color(hue: 0.656, saturation: 0.77, brightness: 0.358))
                        .preferredColorScheme(.dark)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())  // Provide a LocationManager instance
}

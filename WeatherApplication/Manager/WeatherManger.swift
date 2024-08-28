import Foundation
import CoreLocation

class WeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        // Correctly construct the URL with latitude and longitude
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(27)&lon=\(82)&appid=7b1b91602aa43d2c17aebf5843bd4d35&units=metric") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        // Perform the network request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Check for HTTP status code 200
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error Fetching URL Data")
        }
        
        // Decode the JSON response into the ResponseBody struct
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
    
    func saveWeatherData(_ data: ResponseBody, to filename: String) {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent(filename)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: fileURL)
            print("Data saved successfully to \(fileURL)")
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    
    // Method to load weather data from a file
    func loadWeatherData(from filename: String) -> ResponseBody? {
        let fileManager = FileManager.default
        let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = paths[0].appendingPathComponent(filename)
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let weatherData = try decoder.decode(ResponseBody.self, from: jsonData)
            print("Data loaded successfully from \(fileURL)")
            return weatherData
        } catch {
            print("Failed to load data: \(error)")
            return nil
        }
    }
}

struct ResponseBody: Codable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Codable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Codable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Codable{
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Codable{
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

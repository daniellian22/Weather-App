//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Daniel Lian on 7/6/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    // Weather API: 5636c3bf19281300ad982f1fb6532bed

    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=5636c3bf19281300ad982f1fb6532bed&units=metric") else {
            fatalError("Invalid URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, res) = try await URLSession.shared.data(for: urlRequest)
        
        if let httpResponse = res as? HTTPURLResponse {
            print("HTTP Status Code: \(httpResponse.statusCode)")
        }
        
        guard (res as? HTTPURLResponse)?.statusCode == 200 else {
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodedData
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinateResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinateResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

//
//  ModelData.swift
//  WeatherApp
//
//  Created by Daniel Lian on 7/6/24.
//

import SwiftUI
var previewWeather: ResponseBody = load(filename: "weatherData.json")

func load<T: Decodable>( filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource:  filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        
    }
            
}

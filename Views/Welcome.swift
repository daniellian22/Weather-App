//
//  Welcome.swift
//  WeatherApp
//
//  Created by Daniel Lian on 7/5/24.
//

import SwiftUI
import CoreLocationUI
struct Welcome: View {
    @EnvironmentObject var locationManager: LocationManager
    var body: some View {
        VStack {
            VStack(spacing: 20, content: {
                Text("Welcome to the\nWeather App")
                    .font(.title)
                    .bold()
                
                Text("Please share your current location to get the weather in your area")
            })
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .padding()
            .cornerRadius(30)
            .foregroundColor(.white)
        }
    }
}

#Preview {
    Welcome()
}

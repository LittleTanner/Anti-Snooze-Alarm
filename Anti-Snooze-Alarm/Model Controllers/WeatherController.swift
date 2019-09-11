//
//  WeatherController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class WeatherController {
    // URL to create
    // https://api.darksky.net/forecast/83e3034647d9444ddd308d1ba30f44f2/37.8267,-122.4233
    
    func fetchWeatherForecast(latitude: Double, longitude: Double, completion: @escaping (Weather?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.darksky.net/forecast") else {
            completion(nil)
            return
        }
        
        var builtURL = baseURL
        // Append API Key
        builtURL.appendPathComponent("83e3034647d9444ddd308d1ba30f44f2")
        // Append Current Users Location
        builtURL.appendPathComponent("\(latitude),\(longitude)")
        
        print("The builtURL is: \(builtURL)")
        
        let dataTask = URLSession.shared.dataTask(with: builtURL) { (data, response, error) in
            if let error = error {
                print("There was an error with the url in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
//            if let response = response {
//                print("The response from Weather was: \(response)")
//            }
            
            guard let data = data else {
                print("There was no Weather data found in \(#function).")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let WeatherObject = try jsonDecoder.decode(WeatherTopLevel.self, from: data)
                completion(Weather(weatherObject: WeatherObject))
            } catch {
                print("There was an error decoding Weather JSON in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
        
        
        
    }
    
}

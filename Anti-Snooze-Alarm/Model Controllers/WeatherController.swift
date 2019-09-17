//
//  WeatherController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

class WeatherController {
    
    static let sharedInstance = WeatherController()
    
    var weather: [Weather]? {
        
        let moc = CoreDataStack.context
        
        let fetchRequest: NSFetchRequest<Weather> = Weather.fetchRequest()
        
//        fetchRequest.fetchLimit = 1
        
        return (try? moc.fetch(fetchRequest)) ?? []
    }
    
    // Create
    func createWeatherHolder(context: NSManagedObjectContext) {
        _ = Weather(context: context)
        
        saveToPersistentStore()
    }
    
    // Fetch
    
    // URL to create
    // https://api.darksky.net/forecast/83e3034647d9444ddd308d1ba30f44f2/37.8267,-122.4233
    func fetchWeatherForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Weather?) -> Void) {
        
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
                self.saveToPersistentStore()
            } catch {
                print("There was an error decoding Weather JSON in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    // Persistence
    
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("Error saving to persistent Store in \(#function), error: \(error), error localized Description: \(error.localizedDescription)")
        }
    }
}

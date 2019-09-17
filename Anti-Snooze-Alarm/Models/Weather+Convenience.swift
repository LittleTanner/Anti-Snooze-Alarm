//
//  Weather+Convenience.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/16/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import CoreData

extension Weather {
    
    @discardableResult convenience init(weatherObject: WeatherTopLevel, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.currentWeatherTemp = weatherObject.currentWeather.currentTemperature
        self.currentFeelsLikeTemp = weatherObject.currentWeather.currentfeelsLikeTemperature
        self.currentWeatherSummary = weatherObject.currentWeather.currentWeatherSummary
        self.currentWeatherIconName = weatherObject.currentWeather.currentWeatherIconName
        if let weather = weatherObject.dailyWeather.data.first {
            self.dailyMaxTemp = weather.dailyMaxTemperature
            self.dailyMinTemp = weather.dailyMinTemperature
        }
        self.hourlyWeatherSummary = weatherObject.hourlyWeather.hourlyWeatherSummary
    }
    
    enum currentWeatherIconImage: String {
        case clearDay = "clear-day"
        case clearNight = "clear-night"
        case rain
        case snow
        case sleet
        case wind
        case fog
        case cloudy
        case partlyCloudyDay = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
    }
}

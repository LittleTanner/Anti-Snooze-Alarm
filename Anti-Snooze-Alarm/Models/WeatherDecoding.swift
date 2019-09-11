//
//  WeatherDecoding.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

// Top Level
struct WeatherTopLevel: Decodable {
    enum CodingKeys: String, CodingKey {
        case currentWeather = "currently"
        case dailyWeather = "daily"
        case hourlyWeather = "hourly"
    }
    
    var currentWeather: CurrentWeather
    var dailyWeather: DailyWeatherSecondLevel
    var hourlyWeather: HourlyWeather
}

// 2nd Level
struct CurrentWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case currentWeatherIconName = "icon"
        case currentTemperature = "temperature"
        case currentfeelsLikeTemperature = "apparentTemperature"
        case currentWeatherSummary = "summary"
    }
    
    var currentWeatherIconName: String
    var currentTemperature: Double
    var currentfeelsLikeTemperature: Double
    var currentWeatherSummary: String
}

struct DailyWeatherSecondLevel: Decodable {
    var data: [DailyWeather]
}

struct HourlyWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case hourlyWeatherSummary = "summary"
    }
    
    var hourlyWeatherSummary: String
}

// 3rd Level
struct DailyWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case dailyMaxTemperature = "temperatureHigh"
        case dailyMinTemperature = "temperatureLow"
    }
    
    var dailyMaxTemperature: Double
    var dailyMinTemperature: Double
}

//
//  Weather.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/11/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class Weather: Decodable {
    var currentWeatherTemp: Double
    var currentFeelsLikeTemp: Double
    var currentWeatherSummary: String
    var currentWeatherIconName: String
    var dailyMaxTemp: Double?
    var dailyMinTemp: Double?
    var hourlyWeatherSummary: String
    
    init(weatherObject: WeatherTopLevel) {
        self.currentWeatherTemp = weatherObject.currentWeather.currentTemperature
        self.currentFeelsLikeTemp = weatherObject.currentWeather.currentfeelsLikeTemperature
        self.currentWeatherSummary = weatherObject.currentWeather.currentWeatherSummary
        self.currentWeatherIconName = weatherObject.currentWeather.currentWeatherIconName
        self.dailyMaxTemp = weatherObject.dailyWeather.data.first?.dailyMaxTemperature
        self.dailyMinTemp = weatherObject.dailyWeather.data.first?.dailyMinTemperature
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

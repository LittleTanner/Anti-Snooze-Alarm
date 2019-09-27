//
//  FinishedGameViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/25/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreLocation

class FinishedGameViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var currentWeatherIconLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherSummaryLabel: UILabel!
    @IBOutlet weak var currentFeelsLikeTempLabel: UILabel!
    @IBOutlet weak var dailyTempLowLabel: UILabel!
    @IBOutlet weak var dailyTempHighLabel: UILabel!
    @IBOutlet weak var dayWeatherSummaryLabel: UILabel!

    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    var userLatitude: CLLocationDegrees = 0.0
    var userLongitude: CLLocationDegrees = 0.0
    var weatherFetchedArray = WeatherController.sharedInstance.weather
    
    // MARK: - Viewcycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SoundManager.sharedInstance.stopSound()
        AlarmController.sharedInstance.removeNotifications()
    }
    
    // MARK: - Actions
    
    @IBAction func poweredByDarkSkyButtonTapped(_ sender: UIButton) {
        if let darkSkyURL = URL(string: "https://darksky.net/poweredby/") {
            UIApplication.shared.open(darkSkyURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func toHomeScreenButtonTapped(_ sender: UIButton) {
        goToViewController(withIdentifier: "mainNavigationController")
        AlarmController.sharedInstance.scheduleNotificationsForAllDaysBesidesToday()
        ViewManager.sharedInstance.alarmIsSounding = false
    }
    
    
    // MARK: - UI Adjustments
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        
        guard let weatherFetchedArray = weatherFetchedArray,
            let weatherFetched = weatherFetchedArray.first else { return }
        self.currentWeatherLabel.text = "\(Int(weatherFetched.currentWeatherTemp))°"
        self.currentWeatherSummaryLabel.text = weatherFetched.currentWeatherSummary
        self.currentFeelsLikeTempLabel.text = "\(Int(weatherFetched.currentFeelsLikeTemp))°"
        self.dayWeatherSummaryLabel.text = weatherFetched.hourlyWeatherSummary
        
        let temperatureLow = weatherFetched.dailyMinTemp
        self.dailyTempLowLabel.text = "\(Int(temperatureLow))°"
        
        
        let temperatureHigh = weatherFetched.dailyMaxTemp
        self.dailyTempHighLabel.text = "\(Int(temperatureHigh))°"
        
        
        var currentWeatherIcon = ""
        switch weatherFetched.currentWeatherIconName {
        case Weather.currentWeatherIconImage.clearDay.rawValue: currentWeatherIcon = "☀️"
        case Weather.currentWeatherIconImage.clearNight.rawValue: currentWeatherIcon = "☀️"
        case Weather.currentWeatherIconImage.rain.rawValue: currentWeatherIcon = "🌧"
        case Weather.currentWeatherIconImage.snow.rawValue: currentWeatherIcon = "🌨"
        case Weather.currentWeatherIconImage.sleet.rawValue: currentWeatherIcon = "🌨"
        case Weather.currentWeatherIconImage.wind.rawValue: currentWeatherIcon = "💨"
        case Weather.currentWeatherIconImage.fog.rawValue: currentWeatherIcon = "🌫"
        case Weather.currentWeatherIconImage.cloudy.rawValue: currentWeatherIcon = "☁️"
        case Weather.currentWeatherIconImage.partlyCloudyDay.rawValue: currentWeatherIcon = "🌥"
        case Weather.currentWeatherIconImage.partlyCloudyNight.rawValue: currentWeatherIcon = "🌥"
        default: currentWeatherIcon = "🤷🏼‍♂️"
        }
        self.currentWeatherIconLabel.text = currentWeatherIcon
    }
    
    // MARK: - Custom Methods
    
} // End of class

extension FinishedGameViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //        print("The user's current location is at latitude: \(currentLocation.latitude) and longitude: \(currentLocation.longitude)")
        userLatitude = currentLocation.latitude
        userLongitude = currentLocation.longitude
        
        let weather = WeatherController()
        
        self.locationManager.stopUpdatingLocation()
        weather.fetchWeatherForecast(latitude: userLatitude, longitude: userLongitude) { (weather) in
            guard let weather = weather else { return }
            DispatchQueue.main.async {
                self.currentWeatherLabel.text = "\(Int(weather.currentWeatherTemp))°"
                self.currentWeatherSummaryLabel.text = weather.currentWeatherSummary
                self.currentFeelsLikeTempLabel.text = "\(Int(weather.currentFeelsLikeTemp))°"
                self.dayWeatherSummaryLabel.text = weather.hourlyWeatherSummary
                
                let temperatureLow = weather.dailyMinTemp
                self.dailyTempLowLabel.text = "\(Int(temperatureLow))°"
                
                
                let temperatureHigh = weather.dailyMaxTemp
                self.dailyTempHighLabel.text = "\(Int(temperatureHigh))°"
                
                
                var currentWeatherIcon = ""
                switch weather.currentWeatherIconName {
                case Weather.currentWeatherIconImage.clearDay.rawValue: currentWeatherIcon = "☀️"
                case Weather.currentWeatherIconImage.clearNight.rawValue: currentWeatherIcon = "☀️"
                case Weather.currentWeatherIconImage.rain.rawValue: currentWeatherIcon = "🌧"
                case Weather.currentWeatherIconImage.snow.rawValue: currentWeatherIcon = "🌨"
                case Weather.currentWeatherIconImage.sleet.rawValue: currentWeatherIcon = "🌨"
                case Weather.currentWeatherIconImage.wind.rawValue: currentWeatherIcon = "💨"
                case Weather.currentWeatherIconImage.fog.rawValue: currentWeatherIcon = "🌫"
                case Weather.currentWeatherIconImage.cloudy.rawValue: currentWeatherIcon = "☁️"
                case Weather.currentWeatherIconImage.partlyCloudyDay.rawValue: currentWeatherIcon = "🌥"
                case Weather.currentWeatherIconImage.partlyCloudyNight.rawValue: currentWeatherIcon = "🌥"
                default: currentWeatherIcon = "🤷🏼‍♂️"
                }
                self.currentWeatherIconLabel.text = currentWeatherIcon
            }
        }
    }
}

//
//  MainViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var currentWeatherIconLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherSummaryLabel: UILabel!
    @IBOutlet weak var currentFeelsLikeTempLabel: UILabel!
    @IBOutlet weak var dailyTempLowLabel: UILabel!
    @IBOutlet weak var dailyTempHighLabel: UILabel!
    @IBOutlet weak var dayWeatherSummaryLabel: UILabel!
    @IBOutlet weak var alarmHourLabel: UILabel!
    @IBOutlet weak var alarmMinuteLabel: UILabel!
    @IBOutlet weak var alarmAMOrPMLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var alarmToggleButton: UISwitch!
    
    // MARK: - Properties
    
    
    
    let locationManager = CLLocationManager()
    var userLatitude: CLLocationDegrees = 0.0
    var userLongitude: CLLocationDegrees = 0.0
    var weather: Weather?
//    var hasFetchedWeather = false
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
            print("Inside the location services enabled")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewIfNeeded()
        
        guard AlarmController.sharedInstance.alarm != nil else { return }
        updateViews()
        
        guard weather != nil else { return }
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func presentAlertControllerButtonTapped(_ sender: Any) {
        presentAlarmAlert()
    }
    
    @IBAction func poweredByDarkSkyButtonTapped(_ sender: Any) {
        if let darkSkyURL = URL(string: "https://darksky.net/poweredby/") {
            UIApplication.shared.open(darkSkyURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func alarmToggleButtonTapped(_ sender: Any) {
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first {
            
            if alarmToggleButton.isOn == true {
                alarm.isEnabled = true
                print(alarm.isEnabled)
            } else {
                alarm.isEnabled = false
                print(alarm.isEnabled)
                let localNotificationCenter = UNUserNotificationCenter.current()
                localNotificationCenter.removeAllPendingNotificationRequests()
            }
        }
        
        
    }
    
    // MARK: - UI Adjustments
    
    func setsUpUI() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.darkBlue
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainTextColor ?? UIColor.darkGray]
        navigationController?.navigationBar.tintColor = UIColor.blueAccent
        sundayLabel.textColor = UIColor.unSelectedTextColor
        mondayLabel.textColor = UIColor.unSelectedTextColor
        tuesdayLabel.textColor = UIColor.unSelectedTextColor
        wednesdayLabel.textColor = UIColor.unSelectedTextColor
        thursdayLabel.textColor = UIColor.unSelectedTextColor
        fridayLabel.textColor = UIColor.unSelectedTextColor
        saturdayLabel.textColor = UIColor.unSelectedTextColor
    }
    
    // MARK: - Custom Methods
    
    func updateViews() {
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first, let daysOfWeek = alarm.daysOfWeek  {
            guard let alarmTimeAsString = alarm.alarmTimeAsString else { return }
            
            let alarmTime = alarmTimeAsString.components(separatedBy: [":", " "])
            print("alarmTime for label is: \(alarmTime)")
            
            let hours = alarmTime[0]
            let minutes = alarmTime[1]
            let AMorPM = alarmTime[2]
            alarmHourLabel.text = hours
            alarmMinuteLabel.text = minutes
            alarmAMOrPMLabel.text = AMorPM
            
            if daysOfWeek.contains(Alarm.daysOfWeek.sunday.rawValue) {
                sundayLabel.textColor = UIColor.mainTextColor
            } else {
                sundayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.monday.rawValue) {
                mondayLabel.textColor = UIColor.mainTextColor
            } else {
                mondayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.tuesday.rawValue) {
                tuesdayLabel.textColor = UIColor.mainTextColor
            } else {
                tuesdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.wednesday.rawValue) {
                wednesdayLabel.textColor = UIColor.mainTextColor
            } else {
                wednesdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.thursday.rawValue) {
                thursdayLabel.textColor = UIColor.mainTextColor
            } else {
                thursdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.friday.rawValue) {
                fridayLabel.textColor = UIColor.mainTextColor
            } else {
                fridayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.saturday.rawValue) {
                saturdayLabel.textColor = UIColor.mainTextColor
            } else {
                saturdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            
            
            // THERE APPEARS TO BE A SAVING THE WEATHER ISSUE
            if let weatherArray = WeatherController.sharedInstance.weather, let weather = weatherArray.first {
                currentWeatherLabel.text = "\(Int(weather.currentWeatherTemp))"
                currentFeelsLikeTempLabel.text = "\(Int(weather.currentFeelsLikeTemp))"
                currentWeatherSummaryLabel.text = weather.currentWeatherSummary
//                currentWeatherIconLabel.text = weather.currentWeatherIconName
                dailyTempLowLabel.text = "\(Int(weather.dailyMinTemp))"
                dailyTempLowLabel.text = "\(Int(weather.dailyMaxTemp))"
                dayWeatherSummaryLabel.text = weather.hourlyWeatherSummary
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
                currentWeatherIconLabel.text = currentWeatherIcon
            }
            
        } else {
            print("Alarm is nil")
        }
    }
    
    func presentAlarmAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "It's Time To Wake Up!", message: "When ready click start below to get started", preferredStyle: .alert)
        
        // Create action
        let startGame = UIAlertAction(title: "START", style: .default) { (_) in
            print("User tapped the start button, send them to a random mini game")
            
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create a random number
            let randomNumber = Int.random(in: 0...4)
            // Create an array of the view controller's identifier mini game names
            // let arrayOfMiniGames = ["MemorizeNumberGame", "WordOfTheDayGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "MemorizeNumberGame")
            //            let controller = storyboard.instantiateViewController(withIdentifier: arrayOfMiniGames[randomNumber])
            // Present the user with the random mini game view controller
            self.present(controller, animated: true, completion: nil)
        }
        
        // Add action
        alertController.addAction(startGame)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        
        guard let alarms = AlarmController.sharedInstance.alarm else { return }
        
        if segue.identifier == "updateAlarm" {
            
            guard let destinationVC = segue.destination as? SetAlarmTableViewController else { return }
            
            let alarmsToSend = alarms
            
            destinationVC.alarms = alarmsToSend
        }
    }
    
    
} // End of class


extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("The user's current location is at latitude: \(currentLocation.latitude) and longitude: \(currentLocation.longitude)")
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
//                self.hasFetchedWeather = true
                self.currentWeatherIconLabel.text = currentWeatherIcon
                self.weather = weather
            }
        }
    }
}

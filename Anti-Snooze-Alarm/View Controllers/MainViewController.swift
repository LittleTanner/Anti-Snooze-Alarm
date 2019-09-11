//
//  MainViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

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
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
            print("Inside the location services enabled")
        }
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
    
    
    // MARK: - Custom Methods

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
            let arrayOfMiniGames = ["MemorizeNumberGame", "WordOfTheDayGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: arrayOfMiniGames[randomNumber])
            // Present the user with the random mini game view controller
            self.present(controller, animated: true, completion: nil)
        }
        
        // Add action
        alertController.addAction(startGame)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
                
                if let temperatureLow = weather.dailyMinTemp {
                    self.dailyTempLowLabel.text = "\(Int(temperatureLow))°"
                } else {
                    self.dailyTempLowLabel.text = "🤷🏼‍♂️"
                }
                
                if let temperatureHigh = weather.dailyMaxTemp {
                    self.dailyTempHighLabel.text = "\(Int(temperatureHigh))°"
                } else {
                    self.dailyTempLowLabel.text = "🤷🏼‍♂️"
                }
                
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

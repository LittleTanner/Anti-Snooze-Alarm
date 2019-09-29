//
//  ViewManager.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/25/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func goToViewController(withIdentifier identifier: String) {
        // Create an instance of the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Create an instance of a view controller
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        // Present the user with the new view controller
        self.present(controller, animated: true, completion: nil)
    }
}

class ViewManager {
    
    static let sharedInstance = ViewManager()
    
    var alarmIsSounding = false
    
    enum ViewController: String {
        case wordOfTheDay = "WordOfTheDayGame"
        case memorizeNumber = "MemorizeNumberGame"
        case multiplication = "MathGame"
        case tapRedSquares = "SquaresGame"
        case brainGame = "LeftBrainRightBrainGame"
        case homeScreen = "mainNavigationController"
        case areYouAwake = "AreYouAwakeViewController"
        case weatherForecast = "FinishedGameViewController"
    }
    
    let arrayOfMiniGames = [
        ViewController.wordOfTheDay.rawValue,
        ViewController.memorizeNumber.rawValue,
        ViewController.memorizeNumber.rawValue,
        ViewController.tapRedSquares.rawValue,
        ViewController.brainGame.rawValue
    ]
    
}

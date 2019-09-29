//
//  AreYouAwakeViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/26/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class AreYouAwakeViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var areYouAwakeLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
    }
    
    // MARK: - Actions
    
    @IBAction func noButtonTapped(_ sender: Any) {
        // Create a random number
        var randomNumber = 1
        
        if Reachability.isConnectedToNetwork() {
            randomNumber = Int.random(in: 0...4)
        } else {
            randomNumber = Int.random(in: 1...4)
        }
        goToViewController(withIdentifier: ViewManager.sharedInstance.arrayOfMiniGames[randomNumber])
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            SoundManager.sharedInstance.stopSound()
            ViewManager.sharedInstance.alarmIsSounding = false
            AlarmController.sharedInstance.removeNotifications()
            AlarmController.sharedInstance.scheduleNotificationsForAllDaysBesidesToday()
            goToViewController(withIdentifier: ViewManager.ViewController.weatherForecast.rawValue)
        } else {
            SoundManager.sharedInstance.stopSound()
            ViewManager.sharedInstance.alarmIsSounding = false
            AlarmController.sharedInstance.removeNotifications()
            AlarmController.sharedInstance.scheduleNotificationsForAllDaysBesidesToday()
            goToViewController(withIdentifier: ViewManager.ViewController.homeScreen.rawValue)
        }
    }
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        noButton.layer.cornerRadius = noButton.frame.height / 4
        yesButton.layer.cornerRadius = yesButton.frame.height / 4
    }
}

//
//  SettingsViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class SettingsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var navigationBarItem: UINavigationItem!
    
    // MARK: - Properties

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(returnToMainScreen))
    }
    
    // MARK: - Actions
    
    @IBAction func playMiniGameButtonTapped(_ sender: Any) {
        presentAlarmAlert()
    }
    
    @IBAction func playSound(_ sender: Any) {
        guard let alarms = AlarmController.sharedInstance.alarm,
        let alarm = alarms.first,
            let alarmSound = alarm.alarmSound else { return }
//        AudioServicesPlaySystemSound(1005)
//        AudioServicesPlayAlertSound(1005)
//        SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
        
        SoundManager.sharedInstance.playSoundOnce(withVolume: alarm.alarmVolume, alarmSound: alarmSound)
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
            var randomNumber = 1
            
            if Reachability.isConnectedToNetwork() {
                randomNumber = Int.random(in: 0...4)
            } else {
                randomNumber = Int.random(in: 1...4)
            }
            // Create an array of the view controller's identifier mini game names
            let arrayOfMiniGames = ["WordOfTheDayGame", "MemorizeNumberGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
//            let controller = storyboard.instantiateViewController(withIdentifier: "SquaresGame")
            let controller = storyboard.instantiateViewController(withIdentifier: arrayOfMiniGames[randomNumber])
            // Present the user with the random mini game view controller
            self.present(controller, animated: true, completion: nil)
        }
        
        // Add action
        alertController.addAction(startGame)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func returnToMainScreen() {
        self.navigationController?.popViewController(animated: true)
    }
} // End of class


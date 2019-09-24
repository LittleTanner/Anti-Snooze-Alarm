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

    // MARK: - Properties

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    @IBAction func playMiniGameButtonTapped(_ sender: Any) {
        presentAlarmAlert()
    }
    
    @IBAction func playSound(_ sender: Any) {
        
//        guard let alarms = AlarmController.sharedInstance.alarm,
//            let alarm = alarms.first else { return }
        
        guard let alarms = AlarmController.sharedInstance.alarm,
        let alarm = alarms.first else { return }
        SoundManager.sharedInstance.playSound(withVolume: alarm.alarmVolume)
        
//        let date = Date().addingTimeInterval(5)
//        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(runCode), userInfo: nil, repeats: false)
//        RunLoop.main.add(timer, forMode: .common)
        
//        SoundManager.sharedInstance.playSound(withVolume: alarm.alarmVolume)
    }
    
    
    // MARK: - Custom Methods
    
    @objc func runCode() {
        guard let alarms = AlarmController.sharedInstance.alarm,
        let alarm = alarms.first else { return }
        SoundManager.sharedInstance.playSound(withVolume: alarm.alarmVolume)
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
//            let randomNumber = Int.random(in: 0...4)
//            // Create an array of the view controller's identifier mini game names
//            let arrayOfMiniGames = ["MemorizeNumberGame", "WordOfTheDayGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "MemorizeNumberGame")
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

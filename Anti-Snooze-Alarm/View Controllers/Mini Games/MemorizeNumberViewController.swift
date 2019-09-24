//
//  MemorizeNumberViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import AVFoundation

class MemorizeNumberViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var forgotNumberButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    // MARK: - Properties
    var randomNumber = Int.random(in: 100000...999999)
    var seconds = 4
    var countdownTimer = Timer()
    var isTimerRunning = true
    
    var player: AVAudioPlayer?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        runTimer()
    }
    
    // MARK: - Actions
    @IBAction func forgotNumberButtonTapped(_ sender: Any) {
        randomNumber = Int.random(in: 100000...999999)
        randomNumberLabel.text = String(randomNumber)
        seconds = 5
        runTimer()
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        guard let inputNumberText = numberTextField.text else { return }
        
        if inputNumberText == String(randomNumber) {
            print("Correct")
            
            guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first else { return }
            SoundManager.sharedInstance.stopSound()
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
            
            AlarmController.sharedInstance.removeNotifications()
            AlarmController.ScheduleNotifications(alarms: alarms, alarmValuePicker: alarm.alarmTime!, daysOfTheWeekSelected: alarm.daysOfWeek!, volumeSlider: alarm.alarmVolume)
            
        } else {
            print("Incorrect")
        }
    }
    
    // MARK: - UI Adjustments
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkBlue
        randomNumberLabel.text = String(randomNumber)
        forgotNumberButton.isHidden = true
        enterButton.isHidden = true
        numberTextField.isHidden = true
    }
    
    // MARK: - Custom Methods
    func runTimer() {
        countdownTimer.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        seconds -= 1
        
        if seconds >= 0 {
            randomNumberLabel.isHidden = false
            countdownLabel.text = String(seconds)
            numberTextField.isHidden = true
            forgotNumberButton.isHidden = true
            enterButton.isHidden = true
            guard let player = player else { return }
            player.stop()
        } else {
            randomNumberLabel.isHidden = true
            numberTextField.isHidden = false
            forgotNumberButton.isHidden = false
            enterButton.isHidden = false
            countdownTimer.invalidate()
            guard let alarms = AlarmController.sharedInstance.alarm,
                let alarm = alarms.first else { return }
            SoundManager.sharedInstance.playSound(withVolume: alarm.alarmVolume)
        }
    }
} // End of class

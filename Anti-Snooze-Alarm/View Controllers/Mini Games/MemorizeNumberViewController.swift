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
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        runCountdownTimer()
        numberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first,
            let alarmSound = alarm.alarmSound else { return }
        
        SoundManager.sharedInstance.playSoundOnce(withVolume: alarm.alarmVolume, alarmSound: alarmSound)
        TimerManager.sharedInstance.runTimer()
    }
    
    // MARK: - Actions
    
    @IBAction func forgotNumberButtonTapped(_ sender: Any) {
        randomNumber = Int.random(in: 100000...999999)
        randomNumberLabel.text = String(randomNumber)
        seconds = 5
        runCountdownTimer()
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        guard let inputNumberText = numberTextField.text else { return }
        
        if inputNumberText == String(randomNumber) {
            TimerManager.sharedInstance.invalidateTimer()
            SoundManager.sharedInstance.stopSound()
            // Answer Correct, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        } else {
            UIDevice.vibrate()
            self.presentAnswerIncorrectAlert()
        }
    }
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        randomNumberLabel.text = String(randomNumber)
        forgotNumberButton.isHidden = true
        enterButton.isHidden = true
        numberTextField.isHidden = true
        enterButton.layer.cornerRadius = enterButton.frame.height / 4
        forgotNumberButton.layer.cornerRadius = forgotNumberButton.frame.height / 4
    }
    
    // MARK: - Custom Methods
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if numberTextField.text == String(randomNumber) {
            TimerManager.sharedInstance.invalidateTimer()
            SoundManager.sharedInstance.stopSound()
            // Answer Correct, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
    
    func runCountdownTimer() {
        countdownTimer.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateCountdownTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateCountdownTimer() {
        seconds -= 1
        
        if seconds >= 0 {
            numberTextField.text = ""
            numberTextField.resignFirstResponder()
            randomNumberLabel.isHidden = false
            countdownLabel.text = String(seconds)
            numberTextField.isHidden = true
            forgotNumberButton.isHidden = true
            enterButton.isHidden = true
        } else {
            numberTextField.becomeFirstResponder()
            randomNumberLabel.isHidden = true
            numberTextField.isHidden = false
            forgotNumberButton.isHidden = false
            enterButton.isHidden = false
            countdownTimer.invalidate()
        }
    }
    
} // End of class

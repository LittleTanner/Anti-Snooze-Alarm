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
        numberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
            
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
            
            AlarmController.sharedInstance.removeNotifications()
            SoundManager.sharedInstance.stopSound()
            print("MemorizeNumber AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
            
        } else {
            print("Incorrect")
            self.presentAnswerIncorrectAlert()
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if numberTextField.text == String(randomNumber) {
            print("Correct")
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
            
            AlarmController.sharedInstance.removeNotifications()
            SoundManager.sharedInstance.stopSound()
            print("MemorizeNumber AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
        }
    }
    
    func runTimer() {
        countdownTimer.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        seconds -= 1
        
        if seconds >= 0 {
            numberTextField.text = ""
            numberTextField.resignFirstResponder()
            randomNumberLabel.isHidden = false
            countdownLabel.text = String(seconds)
            numberTextField.isHidden = true
            forgotNumberButton.isHidden = true
            enterButton.isHidden = true
            SoundManager.sharedInstance.pauseSound()
            print("MemorizeNumber AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
        } else {
            numberTextField.becomeFirstResponder()
            print("The correct answer is: \(randomNumber)")
            randomNumberLabel.isHidden = true
            numberTextField.isHidden = false
            forgotNumberButton.isHidden = false
            enterButton.isHidden = false
            countdownTimer.invalidate()
            guard let alarms = AlarmController.sharedInstance.alarm,
                let alarm = alarms.first else { return }
            SoundManager.sharedInstance.playSound(withVolume: alarm.alarmVolume)
            print("MemorizeNumber AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
        }
    }
} // End of class

//
//  MathViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class MathViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var countCorrectLabel: UILabel!
    
    @IBOutlet weak var leftNumberLabel: UILabel!
    @IBOutlet weak var rightNumberLabel: UILabel!
    
    @IBOutlet weak var inputNumberTextField: UITextField!
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    
    // MARK: - Properties
    
    var countCorrect = 0
    
    var soundCountdownTimer = Timer()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        updateNumberLabels()
        inputNumberTextField.becomeFirstResponder()
        inputNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        runTimer()
    }
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        updateNumberLabels()
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        guard let numberInputAsString = inputNumberTextField.text,
            let numberInput = Int(numberInputAsString),
            let leftNumberAsString = leftNumberLabel.text,
            let leftNumber = Int(leftNumberAsString),
            let rightNumberAsString = rightNumberLabel.text,
            let rightNumber = Int(rightNumberAsString) else { return }
        
        if countCorrect >= 20 {
            soundCountdownTimer.invalidate()
            SoundManager.sharedInstance.stopSound()
            // You Win, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
        
        if numberInput == (leftNumber * rightNumber) {
            countCorrect += 1
            countCorrectLabel.text = "\(countCorrect)"
            updateNumberLabels()
            inputNumberTextField.text = ""
        } else {
            UIDevice.vibrate()
            presentAnswerIncorrectAlert()
            inputNumberTextField.text = ""
            if countCorrect < 1 {
                countCorrectLabel.text = "0"
            } else {
                countCorrect -= 1
                countCorrectLabel.text = "\(countCorrect)"
            }
        }
    }
    
    // MARK: - Custom Methods
    
    func runTimer() {
        soundCountdownTimer.invalidate()
        soundCountdownTimer = Timer.scheduledTimer(timeInterval: 17, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first,
            let alarmSound = alarm.alarmSound else { return }
        
        SoundManager.sharedInstance.playSoundOnce(withVolume: alarm.alarmVolume, alarmSound: alarmSound)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let numberInputAsString = inputNumberTextField.text,
            let numberInput = Int(numberInputAsString),
            let leftNumberAsString = leftNumberLabel.text,
            let leftNumber = Int(leftNumberAsString),
            let rightNumberAsString = rightNumberLabel.text,
            let rightNumber = Int(rightNumberAsString) else { return }
        
        if numberInput == (leftNumber * rightNumber) {
            countCorrect += 1
            countCorrectLabel.text = "\(countCorrect)"
            updateNumberLabels()
            inputNumberTextField.text = ""
        }
        
        if countCorrect >= 20 {
            soundCountdownTimer.invalidate()
            SoundManager.sharedInstance.stopSound()
            // You win, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        inputNumberTextField.keyboardType = .numberPad
        countCorrectLabel.text = "0"
        enterButton.layer.cornerRadius = enterButton.frame.height / 4
        skipButton.layer.cornerRadius = skipButton.frame.height / 4
    }
    
    func updateNumberLabels() {
        let leftNumber = Int.random(in: 1...12)
        let rightNumber = Int.random(in: 1...12)
        
        leftNumberLabel.text = "\(leftNumber)"
        rightNumberLabel.text = "\(rightNumber)"
    }
} // End of class

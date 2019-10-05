//
//  SquaresViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class SquaresViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var squareButtons: [UIButton]!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var numberOfRoundsCorrectLabel: UILabel!
    
    // MARK: - Properties
    
    var numberOfGreyButtonsTapped = 0
    var numberOfGreySquares = 0
    var numberOfRoundsCount = 0
    
    var soundCountdownTimer = Timer()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        runTimer()
    }
    
    // MARK: - Actions
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        if numberOfRoundsCount >= 10 {
            soundCountdownTimer.invalidate()
            SoundManager.sharedInstance.stopSound()
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        numberOfGreyButtonsTapped = 0
        
        for button in squareButtons {
            button.isEnabled = true
        }
        
        var count = 0
        squareButtons.shuffle()
        for button in squareButtons {
            switch count {
            case _ where count <= 7:
                button.backgroundColor = UIColor.unSelectedTextColor
            case _ where (count > 7) && (count <= 14):
                button.backgroundColor = UIColor.blueAccent
            case _ where (count > 14) && (count <= 21):
                button.backgroundColor = UIColor.mainTextColor
            case _ where count > 21:
                button.backgroundColor = UIColor.redAccent
            default:
                print("Error in \(#function)")
            }
            count += 1
        }
    }
    
    @IBAction func squareButtonTapped(_ sender: UIButton) {
        var GreySquareTotal = 0
        
        for button in squareButtons {
            if button.backgroundColor == UIColor.unSelectedTextColor {
                GreySquareTotal += 1
            }
        }
        numberOfGreySquares = GreySquareTotal
        
        if sender.backgroundColor == UIColor.unSelectedTextColor {
            numberOfGreyButtonsTapped += 1
            sender.isEnabled = false
            sender.setTitle("✔︎", for: .disabled)
            sender.setTitleColor(UIColor.mainTextColor, for: .disabled)
        } else {
            UIDevice.vibrate()
            resetButtonTapped(self)
            for button in squareButtons {
                button.isEnabled = true
            }
            numberOfGreyButtonsTapped = 0
            numberOfRoundsCount = 0
            numberOfRoundsCorrectLabel.text = "\(numberOfRoundsCount)"
        }
        
        if numberOfGreySquares == numberOfGreyButtonsTapped {
            
            numberOfRoundsCount += 1
            
            if numberOfRoundsCount >= 10 {
                soundCountdownTimer.invalidate()
                SoundManager.sharedInstance.stopSound()
                goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
            }
            
            numberOfRoundsCorrectLabel.text = "\(numberOfRoundsCount)"
            numberOfGreyButtonsTapped = 0
            
            for button in squareButtons {
                button.isEnabled = true
            }
            
            var count = 0
            squareButtons.shuffle()
            for button in squareButtons {
                switch count {
                case _ where count <= 7:
                    button.backgroundColor = UIColor.unSelectedTextColor
                case _ where (count > 7) && (count <= 14):
                    button.backgroundColor = UIColor.blueAccent
                case _ where (count > 14) && (count <= 21):
                    button.backgroundColor = UIColor.mainTextColor
                case _ where count > 21:
                    button.backgroundColor = UIColor.redAccent
                default:
                    print("Error in \(#function)")
                }
                count += 1
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
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        
        enterButton.layer.cornerRadius = enterButton.frame.height / 4
        resetButton.layer.cornerRadius = resetButton.frame.height / 4
        
        for button in squareButtons {
            button.isEnabled = true
        }
        
        var count = 0
        squareButtons.shuffle()
        for button in squareButtons {
            switch count {
            case _ where count <= 7:
                button.backgroundColor = UIColor.unSelectedTextColor
            case _ where (count > 7) && (count <= 14):
                button.backgroundColor = UIColor.blueAccent
            case _ where (count > 14) && (count <= 21):
                button.backgroundColor = UIColor.mainTextColor
            case _ where count > 21:
                button.backgroundColor = UIColor.redAccent
            default:
                print("Error in \(#function)")
            }
            count += 1
        }
    }
} // End of class

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
    
    // MARK: - Properties
    
    var numberOfRedButtonsTapped = 0
    var numberOfRedSquares = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first else { return }
        SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
    }
    
    // MARK: - Actions
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        if numberOfRedSquares == numberOfRedButtonsTapped {
            SoundManager.sharedInstance.stopSound()
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        numberOfRedButtonsTapped = 0
        
        var count = 0
        squareButtons.shuffle()
        for button in squareButtons {
            switch count {
            case _ where count <= 7:
                button.backgroundColor = UIColor.redAccent
            case _ where (count > 7) && (count <= 14):
                button.backgroundColor = UIColor.blueAccent
            case _ where (count > 14) && (count <= 21):
                button.backgroundColor = UIColor.mainTextColor
            case _ where count > 21:
                button.backgroundColor = UIColor.unSelectedTextColor
            default:
                print("Error in \(#function)")
            }
            count += 1
        }
    }
    
    @IBAction func squareButtonTapped(_ sender: UIButton) {
        var redSquareTotal = 0
        
        for button in squareButtons {
            if button.backgroundColor == UIColor.redAccent {
                redSquareTotal += 1
            }
        }
        numberOfRedSquares = redSquareTotal
        
        if sender.backgroundColor == UIColor.redAccent {
            numberOfRedButtonsTapped += 1
            sender.isEnabled = false
            sender.setTitle("✔︎", for: .disabled)
            sender.setTitleColor(UIColor.mainTextColor, for: .disabled)
        } else {
            UIDevice.vibrate()
            resetButtonTapped(self)
            for button in squareButtons {
                button.isEnabled = true
            }
            numberOfRedButtonsTapped = 0
        }
                
        if numberOfRedSquares == numberOfRedButtonsTapped {
            SoundManager.sharedInstance.stopSound()
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
    
    // MARK: - Custom Methods
    
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
                button.backgroundColor = UIColor.redAccent
            case _ where (count > 7) && (count <= 14):
                button.backgroundColor = UIColor.blueAccent
            case _ where (count > 14) && (count <= 21):
                button.backgroundColor = UIColor.mainTextColor
            case _ where count > 21:
                button.backgroundColor = UIColor.unSelectedTextColor
            default:
                print("Error in \(#function)")
            }
            count += 1
        }
    }
} // End of class

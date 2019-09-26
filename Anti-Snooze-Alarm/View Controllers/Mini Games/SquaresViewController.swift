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
            goToViewController(withIdentifier: "AreYouAwakeViewController")
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        numberOfRedButtonsTapped = 0
        
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
            default: print("Error")
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
        print("total number of red buttons: \(redSquareTotal)")
        
        if sender.backgroundColor == UIColor.redAccent {
            print("Red button tapped")
            numberOfRedButtonsTapped += 1
            sender.isEnabled = false
        } else {
            print("Tapped a button that isn't red, you lose")
            resetButtonTapped(self)
            for button in squareButtons {
                button.isEnabled = true
            }
            numberOfRedButtonsTapped = 0
        }
        
        print("number of red buttons tapped: \(numberOfRedButtonsTapped)")
        
        if numberOfRedSquares == numberOfRedButtonsTapped {
            goToViewController(withIdentifier: "AreYouAwakeViewController")
        }
    }
    
    // MARK: - Custom Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        
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
            default: print("Error")
            }
            count += 1
        }
    }
} // End of class

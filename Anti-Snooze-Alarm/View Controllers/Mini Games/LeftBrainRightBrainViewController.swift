//
//  LeftBrainRightBrainViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class LeftBrainRightBrainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var countOfCorrectLabel: UILabel!
    @IBOutlet weak var colorToSelectLabel: UILabel!
    
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    // MARK: - Properties
    
    var buttonBackgroundColors: [UIColor] = [UIColor.mainTextColor!, UIColor.redAccent!, UIColor.blueAccent!, UIColor.unSelectedTextColor!]
    var buttonState: Bool = true
    
    var colorsToSelect = ["RED", "WHITE", "BLUE", "GREY"]
    
    var correctCount = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first else { return }
        SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
    }
    
    // MARK: - Actions
    
    @IBAction func topLeftButtonTapped(_ sender: Any) {
        print("Tapped on topLeftButton")
        
        var correctColor = ""
        
        switch buttonBackgroundColors[0] {
        case UIColor.redAccent:
            correctColor = "RED"
        case UIColor.mainTextColor:
            correctColor = "WHITE"
        case UIColor.blueAccent:
            correctColor = "BLUE"
        case UIColor.unSelectedTextColor:
            correctColor = "GREY"
        default: print("IDK, error in \(#function)")
        }
        
        print("label: \(colorToSelectLabel.text!)")
        print("correct Color: \(correctColor)")
        
        if colorToSelectLabel.text == correctColor {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount += 1
            countOfCorrectLabel.text = "\(correctCount)"
        } else {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount = 0
            countOfCorrectLabel.text = "\(correctCount)"
        }
        
        if correctCount >= 10 {
            print("YOU WIN")
            goToViewController(withIdentifier: "FinishedGameViewController")
        }
        
    }
    
    @IBAction func topRightButtonTapped(_ sender: Any) {
        print("Tapped on topRightButton")
        
        var correctColor = ""
        
        switch buttonBackgroundColors[1] {
        case UIColor.redAccent:
            correctColor = "RED"
        case UIColor.mainTextColor:
            correctColor = "WHITE"
        case UIColor.blueAccent:
            correctColor = "BLUE"
        case UIColor.unSelectedTextColor:
            correctColor = "GREY"
        default: print("IDK")
            //            }
        }
        
        print("label: \(colorToSelectLabel.text!)")
        print("correct Color: \(correctColor)")
        
        if colorToSelectLabel.text == correctColor {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount += 1
            countOfCorrectLabel.text = "\(correctCount)"
        } else {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount = 0
            countOfCorrectLabel.text = "\(correctCount)"
        }
        
        if correctCount >= 10 {
            print("YOU WIN")
            goToViewController(withIdentifier: "FinishedGameViewController")
        }
    }
    
    @IBAction func bottomLeftButtonTapped(_ sender: Any) {
        print("Tapped on bottomLeftButton")
        var correctColor = ""
        
        switch buttonBackgroundColors[2] {
        case UIColor.redAccent:
            correctColor = "RED"
        case UIColor.mainTextColor:
            correctColor = "WHITE"
        case UIColor.blueAccent:
            correctColor = "BLUE"
        case UIColor.unSelectedTextColor:
            correctColor = "GREY"
        default: print("IDK")
        }
        
        print("label: \(colorToSelectLabel.text!)")
        print("correct Color: \(correctColor)")
        
        if colorToSelectLabel.text == correctColor {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount += 1
            countOfCorrectLabel.text = "\(correctCount)"
        } else {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount = 0
            countOfCorrectLabel.text = "\(correctCount)"
        }
        
        if correctCount >= 10 {
            print("YOU WIN")
            goToViewController(withIdentifier: "FinishedGameViewController")
        }
    }
    
    @IBAction func bottomRightButtonTapped(_ sender: Any) {
        print("Tapped on bottomRightButton")
        
        var correctColor = ""
        
        switch buttonBackgroundColors[3] {
        case UIColor.redAccent:
            correctColor = "RED"
        case UIColor.mainTextColor:
            correctColor = "WHITE"
        case UIColor.blueAccent:
            correctColor = "BLUE"
        case UIColor.unSelectedTextColor:
            correctColor = "GREY"
        default: print("IDK")
        }
        
        print("label: \(colorToSelectLabel.text!)")
        print("correct Color: \(correctColor)")
        
        if colorToSelectLabel.text == correctColor {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount += 1
            countOfCorrectLabel.text = "\(correctCount)"
        } else {
            randomizeColorsToSelect()
            randomizeButtons()
            randomizeColorToSelectLabelColor()
            correctCount = 0
            countOfCorrectLabel.text = "\(correctCount)"
        }
        
        if correctCount >= 10 {
            print("YOU WIN")
            goToViewController(withIdentifier: "FinishedGameViewController")
        }
    }
    
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        
        colorToSelectLabel.text = colorsToSelect.first
        countOfCorrectLabel.text = "\(correctCount)"
        
        topLeftButton.backgroundColor = buttonBackgroundColors[0]
        topRightButton.backgroundColor = buttonBackgroundColors[1]
        bottomLeftButton.backgroundColor = buttonBackgroundColors[2]
        bottomRightButton.backgroundColor = buttonBackgroundColors[3]
        // Use this to change the label text color of certain words
        // https://www.hackingwithswift.com/articles/113/nsattributedstring-by-example
    }
    
    //    var buttonTitles: [String] = ["RED", "WHITE", "GREY", "BLUE"]
    //    var buttonTitleColors: [UIColor] = [UIColor.red, UIColor.mainTextColor!, UIColor.unSelectedTextColor!, UIColor.blueAccent!]
    
    func randomizeColorToSelectLabelColor() {
        let randomNumber = Int.random(in: 0...2)
        let backgroundColors: [UIColor] = [UIColor.mainTextColor!, UIColor.redAccent!, UIColor.blueAccent!]
        colorToSelectLabel.textColor = backgroundColors[randomNumber]
    }
    
    func randomizeColorsToSelect() {
        colorsToSelect.shuffle()
        colorToSelectLabel.text = colorsToSelect.first
    }
    
    func randomizeButtons() {
        
        buttonBackgroundColors.shuffle()
        
        topLeftButton.backgroundColor = buttonBackgroundColors[0]
        topRightButton.backgroundColor = buttonBackgroundColors[1]
        bottomLeftButton.backgroundColor = buttonBackgroundColors[2]
        bottomRightButton.backgroundColor = buttonBackgroundColors[3]
        
        let arrayOfButtons: [UIButton] = [topLeftButton, topRightButton, bottomLeftButton, bottomRightButton]
        
        for button in arrayOfButtons {
            
            switch button.backgroundColor {
            case UIColor.mainTextColor!:
                if buttonState == true {
                    button.setTitle("RED", for: .normal)
                    button.setTitleColor(UIColor.redAccent, for: .normal)
                } else {
                    button.setTitle("BLUE", for: .normal)
                    button.setTitleColor(UIColor.blueAccent, for: .normal)
                }
            case UIColor.redAccent!:
                if buttonState == true {
                    button.setTitle("WHITE", for: .normal)
                    button.setTitleColor(UIColor.mainTextColor, for: .normal)
                } else {
                    button.setTitle("GREY", for: .normal)
                    button.setTitleColor(UIColor.unSelectedTextColor, for: .normal)
                }
            case UIColor.blueAccent!:
                if buttonState == true {
                    button.setTitle("GREY", for: .normal)
                    button.setTitleColor(UIColor.unSelectedTextColor, for: .normal)
                } else {
                    button.setTitle("WHITE", for: .normal)
                    button.setTitleColor(UIColor.mainTextColor, for: .normal)
                }
            case UIColor.unSelectedTextColor!:
                if buttonState == true {
                    button.setTitle("BLUE", for: .normal)
                    button.setTitleColor(UIColor.blueAccent, for: .normal)
                } else {
                    button.setTitle("RED", for: .normal)
                    button.setTitleColor(UIColor.redAccent, for: .normal)
                }
            default: print("Error in \(#function). 🤷🏼‍♂️")
            }
        }
        buttonState.toggle()
        //        print(buttonState)
    }
} // End of Class

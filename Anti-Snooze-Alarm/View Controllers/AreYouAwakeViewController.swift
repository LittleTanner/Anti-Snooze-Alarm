//
//  AreYouAwakeViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/26/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class AreYouAwakeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var areYouAwakeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setsUpUI()
    }
    
    // MARK: - Actions
    @IBAction func noButtonTapped(_ sender: Any) {
        // Create a random number
        var randomNumber = 1
        
        if Reachability.isConnectedToNetwork() {
            randomNumber = Int.random(in: 0...4)
        } else {
            randomNumber = Int.random(in: 1...4)
        }
        // Create an array of the view controller's identifier mini game names
        let arrayOfMiniGames = ["WordOfTheDayGame", "MemorizeNumberGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
        goToViewController(withIdentifier: arrayOfMiniGames[randomNumber])
    }
    
    @IBAction func yesButtonTapped(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            goToViewController(withIdentifier: "FinishedGameViewController")
        } else {
            goToViewController(withIdentifier: "mainNavigationController")
        }
    }
    
    // MARK: - UI Adjustments
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
    }
}

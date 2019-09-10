//
//  MainViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func presentAlertControllerButtonTapped(_ sender: Any) {
        presentAlarmAlert()
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
            let randomNumber = Int.random(in: 0...4)
            // Create an array of the view controller's identifier mini game names
            let arrayOfMiniGames = ["MemorizeNumberGame", "WordOfTheDayGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: arrayOfMiniGames[randomNumber])
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

}

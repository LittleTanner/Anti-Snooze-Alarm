//
//  SettingsViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController {

    // MARK: - Properties
    var player: AVAudioPlayer?

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    @IBAction func playMiniGameButtonTapped(_ sender: Any) {
        presentAlarmAlert()
    }
    
    @IBAction func playSound(_ sender: Any) {
        
        let date = Date().addingTimeInterval(5)
        let timer = Timer(fireAt: date, interval: 5, target: self, selector: #selector(runCode), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    
    // MARK: - Custom Methods
    
    func presentAlarmAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "It's Time To Wake Up!", message: "When ready click start below to get started", preferredStyle: .alert)
        
        // Create action
        let startGame = UIAlertAction(title: "START", style: .default) { (_) in
            print("User tapped the start button, send them to a random mini game")
            
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create a random number
//            let randomNumber = Int.random(in: 0...4)
//            // Create an array of the view controller's identifier mini game names
//            let arrayOfMiniGames = ["MemorizeNumberGame", "WordOfTheDayGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "MemorizeNumberGame")
            // Present the user with the random mini game view controller
            self.present(controller, animated: true, completion: nil)
        }
        
        // Add action
        alertController.addAction(startGame)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    // List of system Sounds https://github.com/TUNER88/iOSSystemSoundsLibrary
//    This workds to play a sound :)
//    func playSound() {
//        let soundURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/tweet_sent.caf")
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            player = try AVAudioPlayer(contentsOf: soundURL as URL, fileTypeHint: "caf")
//
//            guard let player = player else { return }
//
//            // This keeps the sound looping continuously
//            // player.numberOfLoops = -1
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
    @objc func runCode() {
        playSound()
    }
    
    func playSound() {
        let soundURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/ReceivedMessage.caf")

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: soundURL as URL, fileTypeHint: "caf")

            guard let player = player else { return }
            
//            player.numberOfLoops = -1
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class

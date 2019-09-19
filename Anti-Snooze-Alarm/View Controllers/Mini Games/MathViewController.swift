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
    
    // MARK: - Properties
    var countCorrect = 0
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setsUpUI()
        updateNumberLabels()
        inputNumberTextField.becomeFirstResponder()
        inputNumberTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
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
        
        if countCorrect >= 10 {
            print("YOU WIN")
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
        }
        
        if numberInput == (leftNumber * rightNumber) {
            print("Correct")
            countCorrect += 1
            countCorrectLabel.text = "\(countCorrect)"
            updateNumberLabels()
            inputNumberTextField.text = ""
        } else {
            print("Incorrect")
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let numberInputAsString = inputNumberTextField.text,
            let numberInput = Int(numberInputAsString),
            let leftNumberAsString = leftNumberLabel.text,
            let leftNumber = Int(leftNumberAsString),
            let rightNumberAsString = rightNumberLabel.text,
            let rightNumber = Int(rightNumberAsString) else { return }
        
        if numberInput == (leftNumber * rightNumber) {
            print("Correct")
            countCorrect += 1
            countCorrectLabel.text = "\(countCorrect)"
            updateNumberLabels()
            inputNumberTextField.text = ""
        }
        
        if countCorrect >= 10 {
            print("YOU WIN")
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func presentAnswerIncorrectAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "Incorrect", message: nil, preferredStyle: .alert)
        
        // Create action
        let tryAgain = UIAlertAction(title: "TRY AGAIN", style: .cancel, handler: nil)
        
        // Add action
        alertController.addAction(tryAgain)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkBlue
        inputNumberTextField.keyboardType = .numberPad
        countCorrectLabel.text = "0"
    }
    
    func updateNumberLabels() {
        
        let leftNumber = Int.random(in: 1...12)
        let rightNumber = Int.random(in: 1...12)
        
        leftNumberLabel.text = "\(leftNumber)"
        rightNumberLabel.text = "\(rightNumber)"
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

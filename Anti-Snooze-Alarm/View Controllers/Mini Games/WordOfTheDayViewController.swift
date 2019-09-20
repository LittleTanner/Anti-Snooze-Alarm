//
//  WordOfTheDayViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class WordOfTheDayViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordDefinitionLabel: UILabel!
    @IBOutlet weak var inputDefinitionTextField: UITextView!
    
    
    // MARK: - Properties
    
    var randomWord = ""
    var word = ""
    var definition = ""
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkBlue
        inputDefinitionTextField.becomeFirstResponder()
        setsUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let randomWordController = RandomWordController()
        randomWordController.fetchRandomWord { (randomWord) in
            
            guard let randomWord = randomWord else { return }
            
            self.randomWord = randomWord
            print(randomWord)
            
            let wordController = WordController()
            
            wordController.fetchWordOfTheDay(word: randomWord) { (word) in
                guard let word = word,
                    let searchedWord = word.word,
                    let definition = word.definition else { return }
                
                self.word = searchedWord
                let definitionWithTab = definition.components(separatedBy: "\t")
                
                let definitionRandomizedCases = definitionWithTab[1].map {
                    if Int.random(in: 0...1) == 0 {
                        return String($0).lowercased()
                    }
                    return String($0).uppercased()
                    }.joined(separator: "")
                
                self.definition = definitionRandomizedCases
                
                print("Searched Word: \(searchedWord)")
                print("Definition: \(definition)")
                
                self.setsUpUI()
            }
        }
        
//        let wordController = WordController()
//
//        wordController.fetchWordOfTheDay(word: "test") { (word) in
//            guard let word = word,
//                let searchedWord = word.word,
//                let definition = word.definition else { return }
//
//            self.word = searchedWord
//            let definitionWithTab = definition.components(separatedBy: "\t")
//
//            let definitionRandomizedCases = definitionWithTab[1].map {
//                if Int.random(in: 0...1) == 0 {
//                    return String($0).lowercased()
//                }
//                return String($0).uppercased()
//                }.joined(separator: "")
//
//            self.definition = definitionRandomizedCases
//
//            print("Searched Word: \(searchedWord)")
//            print("Definition: \(definition)")
//        }
    }
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        // generate random word, fetch random word, update UI
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        guard let inputText = inputDefinitionTextField.text else { return }
        
        if definition == inputText {
            print("Correct")
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
        } else {
            print("Incorrect")
        }
    }
    
    
    // MARK: - Custom Methods
    
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        DispatchQueue.main.async {
            self.wordLabel.text = self.word
            self.wordDefinitionLabel.text = self.definition
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


}

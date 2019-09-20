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
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    
    // MARK: - Properties
    
    var word = ""
    var definition = "Pulling Definition From The Web.. Please wait typically about 5 seconds"
    
    let wordController = WordController()
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDefinitionTextField.delegate = self
        inputDefinitionTextField.becomeFirstResponder()
        setsUpUI()
        generateRandomWord()
        updateViews()
        fetchWord()
    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        generateRandomWord()
//        updateViews()
//        fetchWord()
//    }
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        generateRandomWord()
        fetchWord()
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
            presentAnswerIncorrectAlert()
        }
    }
    
    
    // MARK: - Custom Methods
    
    func generateRandomWord() {
        let count = ListOfWords.sharedInstance.arrayOfEnglishWords.count
        let randomNumber = Int.random(in: 0...count)
        
        word = ListOfWords.sharedInstance.arrayOfEnglishWords[randomNumber]
        print("Generated Random Word: \(word)")
    }
    
    func fetchWord() {
//        let wordController = WordController()
        
        wordController.fetchWordOfTheDay(word: word) { (word) in
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
            
            self.updateViews()
            self.unhideButtons()
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
        self.wordLabel.text = self.word
        self.wordDefinitionLabel.text = self.definition
        skipButton.isHidden = true
        enterButton.isHidden = true
        
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.wordLabel.text = self.word
            self.wordDefinitionLabel.text = self.definition
        }
    }
    
    func unhideButtons() {
        DispatchQueue.main.async {
            self.skipButton.isHidden = false
            self.enterButton.isHidden = false
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

extension WordOfTheDayViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let inputText = inputDefinitionTextField.text else { return }
        
        if definition == inputText {
            print("Correct")
            // Create an instance of the main storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // Create an instance of the view controller
            let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController")
            // Present the user with the main view controller
            self.present(controller, animated: true, completion: nil)
        }
    }
}

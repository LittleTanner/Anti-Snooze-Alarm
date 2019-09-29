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
    var definition = "Pulling Definition From The Web.. Please wait typically about 5 seconds."
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputDefinitionTextField.delegate = self
        inputDefinitionTextField.becomeFirstResponder()
        setsUpUI()
        generateRandomWord()
        updateViews()
        fetchWord()
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first else { return }
        SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
    }
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        generateRandomWord()
        fetchWord()
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        guard let inputText = inputDefinitionTextField.text else { return }
        
        if definition == inputText {
            // Answer correct, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        } else {
            UIDevice.vibrate()
            presentAnswerIncorrectAlert()
        }
    }
    
    // MARK: - Custom Methods
    
    func generateRandomWord() {
        let count = ListOfWords.sharedInstance.arrayOfEnglishWords.count
        let randomNumber = Int.random(in: 0...(count - 1))
        word = ListOfWords.sharedInstance.arrayOfEnglishWords[randomNumber]
    }
    
    func fetchWord() {
        WordController.shareInstance.fetchWordOfTheDay(word: word) { (word) in
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
            self.updateViews()
            self.unhideButtons()
        }
    }
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        self.wordLabel.text = self.word
        self.wordDefinitionLabel.text = "Definition: \(self.definition)"
        skipButton.isHidden = true
        enterButton.isHidden = true
        enterButton.layer.cornerRadius = enterButton.frame.height / 4
        skipButton.layer.cornerRadius = skipButton.frame.height / 4
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            self.wordLabel.text = self.word
            self.wordDefinitionLabel.text = "Definition: \(self.definition)"
        }
    }
    
    func unhideButtons() {
        DispatchQueue.main.async {
            self.skipButton.isHidden = false
            self.enterButton.isHidden = false
        }
    }
} // End of class

extension WordOfTheDayViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let inputText = inputDefinitionTextField.text else { return }
        
        if definition == inputText {
            // Answer correct, go to are you awake page
            goToViewController(withIdentifier: ViewManager.ViewController.areYouAwake.rawValue)
        }
    }
}

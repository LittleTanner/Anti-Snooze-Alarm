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
    
    
    // MARK: - Properties
    var word = ""
    var definition = ""
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setsUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let wordController = WordController()
        
        wordController.fetchWordOfTheDay(word: "test") { (word) in
            guard let word = word,
                let searchedWord = word.word,
                let definition = word.definition else { return }
            
            self.word = searchedWord
            self.definition = definition
            
            print("Searched Word: \(searchedWord)")
            print("Definition: \(definition)")
        }
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkBlue
        DispatchQueue.main.async {
            // labels for word and definition updated
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

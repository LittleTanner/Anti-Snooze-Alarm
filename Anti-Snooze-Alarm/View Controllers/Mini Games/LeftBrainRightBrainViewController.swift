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
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setsUpUI()
    }
    
    // MARK: - Actions
    
    
    // MARK: - Custom Methods
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkBlue
        
        // Use this to change the label text color of certain words
        // https://www.hackingwithswift.com/articles/113/nsattributedstring-by-example
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

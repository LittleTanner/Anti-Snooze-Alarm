//
//  InformationViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/29/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(returnToMainScreen))
    }
    
    // MARK: - Actions
    
    @IBAction func datamuseButtonTapped(_ sender: Any) {
        if let datamuseURL = URL(string: "https://www.datamuse.com/api/") {
            UIApplication.shared.open(datamuseURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func poweredByDarkSkyButtonTapped(_ sender: Any) {
        if let darkSkyURL = URL(string: "https://darksky.net/poweredby/") {
            UIApplication.shared.open(darkSkyURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        if let privacyPolicyURL = URL(string: "https://sites.google.com/view/antisnoozeprivacypolicy/home") {
            UIApplication.shared.open(privacyPolicyURL, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - UI Adjustments
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
    }
    
    // MARK: - Custom Methods
    
    @objc func returnToMainScreen() {
        SoundManager.sharedInstance.stopSound()
        goToViewController(withIdentifier: ViewManager.ViewController.homeScreen.rawValue)
    }
}

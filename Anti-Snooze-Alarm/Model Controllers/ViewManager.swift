//
//  ViewManager.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/25/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func goToViewController(withIdentifier identifier: String) {
        // Create an instance of the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Create an instance of the view controller
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        // Present the user with the main view controller
        self.present(controller, animated: true, completion: nil)
    }
}

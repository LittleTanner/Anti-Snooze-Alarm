//
//  AlertManager.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/25/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import UserNotificationsUI

extension UIViewController {
    
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
    
    func presentAlarmNotActiveAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "No Days Selected", message: "This means the alarm is turned off. Is this what you want?", preferredStyle: .alert)
        
        // Create action
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.goToViewController(withIdentifier: "mainNavigationController")
        }
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        // Add action
        alertController.addAction(no)
        alertController.addAction(yes)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAlarmWontRepeatAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "Alarm Won't Repeat", message: "This app currently needs you to select more than one day for the alarm to repeat. Did you mean to do this?", preferredStyle: .alert)
        
        // Create action
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.goToViewController(withIdentifier: "mainNavigationController")
        }
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        // Add action
        alertController.addAction(no)
        alertController.addAction(yes)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentSelectedPMAlert() {
        // Create alert controller
        let alertController = UIAlertController(title: "Alarm Time Is Set For PM", message: "Did you mean to do this?", preferredStyle: .alert)
        
        // Create action
        let yes = UIAlertAction(title: "Yes", style: .default) { (_) in
            self.goToViewController(withIdentifier: "mainNavigationController")
        }
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        // Add action
        alertController.addAction(no)
        alertController.addAction(yes)
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}

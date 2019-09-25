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
}

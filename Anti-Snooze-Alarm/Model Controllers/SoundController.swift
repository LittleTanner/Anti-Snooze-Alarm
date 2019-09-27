//
//  SoundController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/26/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class SoundController {
    
    static let sharedInstance = SoundController()
    
    let sounds: [Sound]
    
    init() {
        self.sounds = [
            Sound(soundName: "Drum"),
            Sound(soundName: "Old Fashion Alarm Clock")
        ]
    }
        
        
      
    
    
}

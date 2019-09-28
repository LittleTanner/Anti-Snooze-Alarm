//
//  Device.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/28/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
}

//
//  Alarm.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class Alarm {
    
    enum daysOfWeek: String {
        case sunday
        case monday
        case wednesday
        case thursday
        case friday
        case saturday
    }
    
    var alarmTime: Date
    var daysOfWeek: [String]
    var alarmSound: String
    var alarmVolume: Int
    var isEnabled: Bool
    var alarmTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: alarmTime)
    }
    
    init(alarmTime: Date, daysOfWeek: [String], alarmSound: String = "default", alarmVolume: Int, isEnabled: Bool = true) {
        self.alarmTime = alarmTime
        self.daysOfWeek = daysOfWeek
        self.alarmSound = alarmSound
        self.alarmVolume = alarmVolume
        self.isEnabled = isEnabled
    }
}

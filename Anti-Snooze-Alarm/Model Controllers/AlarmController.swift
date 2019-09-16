//
//  AlarmController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/13/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit


class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarm: Alarm?
    
    // CRUD
    
    // Create Alarm
    func createAlarm(alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Int) {
        let alarm = Alarm(alarmTime: alarmTime, daysOfWeek: daysOfWeek, alarmSound: alarmSound, alarmVolume: alarmVolume)
        
        self.alarm = alarm
        
        // Save to core data
    }
    
    // Read Alarm
    func fetchAlarm(alarm: Alarm) {
        self.alarm = alarm
    }
    
    // Update Alarm
    func updateAlarm(alarm: Alarm, alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Int, isEnabled: Bool) {
        alarm.alarmTime = alarmTime
        alarm.daysOfWeek = daysOfWeek
        alarm.alarmSound = alarmSound
        alarm.alarmVolume = alarmVolume
        alarm.isEnabled = isEnabled
        
        // save to core data
    }
}

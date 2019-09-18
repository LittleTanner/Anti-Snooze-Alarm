//
//  AlarmController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/13/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreData


class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarm: [Alarm]? {
        
        let moc = CoreDataStack.context
        
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        
        return (try? moc.fetch(fetchRequest)) ?? []
    }
    
    // CRUD
    
    // Create Alarm
    func createAlarm(alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Float) {
        let _ = Alarm(alarmTime: alarmTime, daysOfWeek: daysOfWeek, alarmSound: alarmSound, alarmVolume: alarmVolume)

        // Save to core data
        saveToPersistentStore()
        
    }
    
    // Update Alarm
    func updateAlarm(alarm: Alarm, alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Float, isEnabled: Bool) {
        alarm.alarmTime = alarmTime
        alarm.daysOfWeek = daysOfWeek
        alarm.alarmSound = alarmSound
        alarm.alarmVolume = alarmVolume
        alarm.isEnabled = isEnabled
        alarm.alarmTimeAsString = alarmTime.stringWith(timeStyle: .short)
        
        // save to core data
        saveToPersistentStore()
        
    }
    
    // Persistence
    
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("Error saving to persistent Store in \(#function), error: \(error), error localized Description: \(error.localizedDescription)")
        }
    }
}

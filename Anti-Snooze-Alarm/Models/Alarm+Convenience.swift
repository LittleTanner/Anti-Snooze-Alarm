//
//  Alarm+Convenience.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/16/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import CoreData

extension Alarm {
    @discardableResult convenience init(alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Int16, isEnabled: Bool = true, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.alarmTime = alarmTime
        self.daysOfWeek = daysOfWeek
        self.alarmSound = alarmSound
        self.alarmVolume = alarmVolume
        self.isEnabled = isEnabled
        self.alarmTimeAsString = alarmTime.stringWith(timeStyle: .short)
    }
    
    enum daysOfWeek: String {
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }
}



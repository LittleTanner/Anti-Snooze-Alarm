//
//  AlarmController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/13/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications



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
    
    static func ScheduleNotifications(alarms: [Alarm]?, alarmValuePicker: Date, daysOfTheWeekSelected: [String], volumeSlider: Float) {
        
        if let alarms = alarms, let alarm = alarms.first {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, alarmTime: alarmValuePicker, daysOfWeek: daysOfTheWeekSelected, alarmSound: "default", alarmVolume: volumeSlider, isEnabled: true)
        } else {
            AlarmController.sharedInstance.createAlarm(alarmTime: alarmValuePicker, daysOfWeek: daysOfTheWeekSelected, alarmSound: "default", alarmVolume: volumeSlider)
        }
        
        print("Volume Selected From Slider: \(volumeSlider)")
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.sunday.rawValue) {
            CreateNotifications(forDay: 1)
            
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.monday.rawValue) {
            CreateNotifications(forDay: 2)
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.tuesday.rawValue) {
            CreateNotifications(forDay: 3)
//            for num in 0...4 {
//                CreateNotificationsPlus(forDay: 3, minutesToAdd: num)
//            }
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.wednesday.rawValue) {
            CreateNotifications(forDay: 4)
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.thursday.rawValue) {
            CreateNotifications(forDay: 5)
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.friday.rawValue) {
            CreateNotifications(forDay: 6)
        }
        
        if daysOfTheWeekSelected.contains(Alarm.daysOfWeek.saturday.rawValue) {
            CreateNotifications(forDay: 7)
        }
        
    }
    
    static func CreateNotifications(forDay dayOfWeek: Int) {
        
        guard let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first else { return }
        
        guard let alarmTimeAsString = alarm.alarmTimeAsString else { return }
        
        var date = DateComponents()
        
        let alarmTime = alarmTimeAsString.components(separatedBy: [":", " "])
        
        let hours = alarmTime[0]
        let minutes = alarmTime[1]
        let AMorPM = alarmTime[2]
        
        if AMorPM == "AM" {
            if Int(hours) == 12 {
                date.hour = 0
            } else {
                date.hour = Int(hours)
            }
        } else {
            if Int(hours) == 12 {
                date.hour = Int(hours)
            } else {
                date.hour = Int(hours)! + 12
            }
        }
        
        date.minute = Int(minutes)
        date.weekday = dayOfWeek
        date.second = 0
        
        var alertName = ""
        
        switch dayOfWeek {
        case 1: alertName = "localSundayAlert"
        case 2: alertName = "localMondayAlert"
        case 3: alertName = "localTuesdayAlert"
        case 4: alertName = "localWednesdayAlert"
        case 5: alertName = "localThursdayAlert"
        case 6: alertName = "localFridayAlert"
        case 7: alertName = "localSaturdayAlert"
        default: print("🤷🏼‍♂️ something wrong with localAlert")
        }
        
        // content of our notification (what it looks like)
        let content = UNMutableNotificationContent()
        content.title = "TIME TO WAKE UP!!!"
        content.body = "Today is a great day, wake up now to enjoy it 😃"
        let notificationSound = UNNotificationSoundName("Birds.caf")
        content.sound = UNNotificationSound.init(named: notificationSound)
        
        for num in 1...8 {
            date.second = date.second! + 7
//            print(date)
            // how long into the future it will be scheduled
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            // Creating a custom name for each notifcation
            let customAlertName = alertName + "\(num)"
            // the completed request ( identifier + content + trigger)
            let request = UNNotificationRequest(identifier: customAlertName, content: content, trigger: trigger)
            // schedule the request
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Notification failed")
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("Pending notifications scheduled: \(notifications.count)")
        }
    }
    
    static func CreateNotificationsPlus(forDay dayOfWeek: Int, minutesToAdd: Int) {
            
            guard let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first else { return }
            
            guard let alarmTimeAsString = alarm.alarmTimeAsString else { return }
            
            var date = DateComponents()
            
            let alarmTime = alarmTimeAsString.components(separatedBy: [":", " "])
            
            let hours = alarmTime[0]
            let minutes = alarmTime[1]
            let AMorPM = alarmTime[2]
            
            if AMorPM == "AM" {
                if Int(hours) == 12 {
                    date.hour = 0
                } else {
                    date.hour = Int(hours)
                }
            } else {
                if Int(hours) == 12 {
                    date.hour = Int(hours)
                } else {
                    date.hour = Int(hours)! + 12
                }
            }
            
            date.minute = Int(minutes)! + minutesToAdd
            date.weekday = dayOfWeek
            date.second = 0
            
            // content of our notification (what it looks like)
            let content = UNMutableNotificationContent()
            content.title = "TIME TO WAKE UP!!!"
            content.body = "Today is a great day, wake up now to enjoy it 😃"
            let notificationSound = UNNotificationSoundName("Birds.caf")
            content.sound = UNNotificationSound.init(named: notificationSound)
            
            for _ in 1...8 {
                date.second = date.second! + 7
    //            print(date)
                // how long into the future it will be scheduled
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
                // Creating a custom name for each notifcation
                let customAlertName = UUID().uuidString
                // the completed request ( identifier + content + trigger)
                let request = UNNotificationRequest(identifier: customAlertName, content: content, trigger: trigger)
                
                // schedule the request
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Notification failed")
                        print(error.localizedDescription)
                        print(error)
                    }
                }
            }
            
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
                print("Pending notifications scheduled: \(notifications.count)")
            }
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
    
    
    // Delete
    func removeNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("Pending notifications scheduled: \(notifications.count)")
        }
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

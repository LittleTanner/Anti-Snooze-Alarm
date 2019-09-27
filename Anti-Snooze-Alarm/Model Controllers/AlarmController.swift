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
    
    let sounds: [String] = [
        "Sonar",
        "Magical",
        "Doorbell",
        "Thunder",
        "SciFi",
        "Drum",
        "Old Fashion Alarm Clock"
    ]
    
    
    // CRUD
    
    // Create Alarm
    func createAlarm(alarmTime: Date, daysOfWeek: [String], alarmSound: String, alarmVolume: Float) {
        let _ = Alarm(alarmTime: alarmTime, daysOfWeek: daysOfWeek, alarmSound: alarmSound, alarmVolume: alarmVolume)

        // Save to core data
        saveToPersistentStore()
    }
    
    static func ScheduleNotifications(alarms: [Alarm]?, alarmValuePicker: Date, daysOfTheWeekSelected: [String], volumeSlider: Float, alarmSound: String) {
        
        if let alarms = alarms, let alarm = alarms.first {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, alarmTime: alarmValuePicker, daysOfWeek: daysOfTheWeekSelected, alarmSound: alarmSound, alarmVolume: volumeSlider, isEnabled: true)
        } else {
            AlarmController.sharedInstance.createAlarm(alarmTime: alarmValuePicker, daysOfWeek: daysOfTheWeekSelected, alarmSound: alarmSound, alarmVolume: volumeSlider)
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
    
    static func scheduleNotificationsForAllDaysBesidesToday() {
        let today = Calendar.current.component(.weekday, from: Date())
        
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first, let daysOfWeek = alarm.daysOfWeek else { return }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.sunday.rawValue) && today != 1 {
            CreateNotifications(forDay: 1)
            print("Notifications scheduled for Sunday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.monday.rawValue) && today != 2 {
            CreateNotifications(forDay: 2)
            print("Notifications scheduled for Monday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.tuesday.rawValue) && today != 3 {
            CreateNotifications(forDay: 3)
            print("Notifications scheduled for Tuesday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.wednesday.rawValue) && today != 4 {
            CreateNotifications(forDay: 4)
            print("Notifications scheduled for Wednesday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.thursday.rawValue) && today != 5 {
            CreateNotifications(forDay: 5)
            print("Notifications scheduled for Thursday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.friday.rawValue) && today != 6 {
            CreateNotifications(forDay: 6)
            print("Notifications scheduled for Friday")
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.saturday.rawValue) && today != 7 {
            CreateNotifications(forDay: 7)
            print("Notifications scheduled for Saturday")
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
        case 1: alertName = "SundayAlert"
        case 2: alertName = "MondayAlert"
        case 3: alertName = "TuesdayAlert"
        case 4: alertName = "WednesdayAlert"
        case 5: alertName = "ThursdayAlert"
        case 6: alertName = "FridayAlert"
        case 7: alertName = "SaturdayAlert"
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
    
    func removeNotificationsForToday() {
        
        var alertNameArray: [String] = []
        
        let currentWeekday = Calendar.current.component(.weekday, from: Date())
        
        switch currentWeekday {
        case 1: alertNameArray = ["SundayAlert1", "SundayAlert2", "SundayAlert3", "SundayAlert4", "SundayAlert5", "SundayAlert6", "SundayAlert7", "SundayAlert8"]
        case 2: alertNameArray = ["MondayAlert1", "MondayAlert2", "MondayAlert3", "MondayAlert4", "MondayAlert5", "MondayAlert6", "MondayAlert7", "MondayAlert8"]
        case 3: alertNameArray = ["TuesdayAlert1", "TuesdayAlert2", "TuesdayAlert3", "TuesdayAlert4", "TuesdayAlert5", "TuesdayAlert6", "TuesdayAlert7", "TuesdayAlert8"]
        case 4: alertNameArray = ["WednesdayAlert1", "WednesdayAlert2", "WednesdayAlert3", "WednesdayAlert4", "WednesdayAlert5", "WednesdayAlert6", "WednesdayAlert7", "WednesdayAlert8"]
        case 5: alertNameArray = ["ThursdayAlert1", "ThursdayAlert2", "ThursdayAlert3", "ThursdayAlert4", "ThursdayAlert5", "ThursdayAlert6", "ThursdayAlert7", "ThursdayAlert8"]
        case 6: alertNameArray = ["FridayAlert1", "FridayAlert2", "FridayAlert3", "FridayAlert4", "FridayAlert5", "FridayAlert6", "FridayAlert7", "FridayAlert8"]
        case 7: alertNameArray = ["SaturdayAlert1", "SaturdayAlert2", "SaturdayAlert3", "SaturdayAlert4", "SaturdayAlert5", "SaturdayAlert6", "SaturdayAlert7", "SaturdayAlert8"]
        default: print("🤷🏼‍♂️ something wrong with removing localAlert for day of week: \(currentWeekday)")
        }
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: alertNameArray)
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

//
//  MainViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class MainViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var alarmHourLabel: UILabel!
    @IBOutlet weak var alarmMinuteLabel: UILabel!
    @IBOutlet weak var alarmAMOrPMLabel: UILabel!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var alarmToggleButton: UISwitch!
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewIfNeeded()
        print("MainVC AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print("Pending notifications scheduled: \(notifications.count)")
        }
        
        guard AlarmController.sharedInstance.alarm != nil else { return }
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func poweredByDarkSkyButtonTapped(_ sender: Any) {
        if let darkSkyURL = URL(string: "https://darksky.net/poweredby/") {
            UIApplication.shared.open(darkSkyURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func alarmToggleButtonTapped(_ sender: Any) {
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first {
            
            if alarmToggleButton.isOn == true {
                alarm.isEnabled = true
                print("Alarm is set to: \(alarm.isEnabled)")
                AlarmController.ScheduleNotifications(alarms: alarms, alarmValuePicker: alarm.alarmTime!, daysOfTheWeekSelected: alarm.daysOfWeek!, volumeSlider: alarm.alarmVolume)
            } else {
                alarm.isEnabled = false
                print("Alarm is set to: \(alarm.isEnabled)")
                AlarmController.sharedInstance.removeNotifications()
            }
        } else {
            print("No alarm detected")
        }
    }
    
    // MARK: - UI Adjustments
    
    func setsUpUI() {
        self.view.backgroundColor = UIColor.darkColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.darkColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainTextColor ?? UIColor.darkGray]
        navigationController?.navigationBar.tintColor = UIColor.blueAccent
        sundayLabel.textColor = UIColor.unSelectedTextColor
        mondayLabel.textColor = UIColor.unSelectedTextColor
        tuesdayLabel.textColor = UIColor.unSelectedTextColor
        wednesdayLabel.textColor = UIColor.unSelectedTextColor
        thursdayLabel.textColor = UIColor.unSelectedTextColor
        fridayLabel.textColor = UIColor.unSelectedTextColor
        saturdayLabel.textColor = UIColor.unSelectedTextColor
    }
    
    func updateViews() {
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first, let daysOfWeek = alarm.daysOfWeek  {
            guard let alarmTimeAsString = alarm.alarmTimeAsString else { return }
            
            alarmToggleButton.isOn = alarm.isEnabled
            
            let alarmTime = alarmTimeAsString.components(separatedBy: [":", " "])
            
            let hours = alarmTime[0]
            let minutes = alarmTime[1]
            let AMorPM = alarmTime[2]
            alarmHourLabel.text = hours
            alarmMinuteLabel.text = minutes
            alarmAMOrPMLabel.text = AMorPM
            
            if daysOfWeek.contains(Alarm.daysOfWeek.sunday.rawValue) {
                sundayLabel.textColor = UIColor.mainTextColor
            } else {
                sundayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.monday.rawValue) {
                mondayLabel.textColor = UIColor.mainTextColor
            } else {
                mondayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.tuesday.rawValue) {
                tuesdayLabel.textColor = UIColor.mainTextColor
            } else {
                tuesdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.wednesday.rawValue) {
                wednesdayLabel.textColor = UIColor.mainTextColor
            } else {
                wednesdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.thursday.rawValue) {
                thursdayLabel.textColor = UIColor.mainTextColor
            } else {
                thursdayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.friday.rawValue) {
                fridayLabel.textColor = UIColor.mainTextColor
            } else {
                fridayLabel.textColor = UIColor.unSelectedTextColor
            }
            
            if daysOfWeek.contains(Alarm.daysOfWeek.saturday.rawValue) {
                saturdayLabel.textColor = UIColor.mainTextColor
            } else {
                saturdayLabel.textColor = UIColor.unSelectedTextColor
            }
        } else {
            print("Alarm is nil")
        }
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        
        guard let alarms = AlarmController.sharedInstance.alarm else { return }
        
        if segue.identifier == "updateAlarm" {
            
            guard let destinationVC = segue.destination as? SetAlarmTableViewController else { return }
            
            let alarmsToSend = alarms
            
            destinationVC.alarms = alarmsToSend
        }
    }
    
} // End of class

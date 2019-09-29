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
    
    @IBOutlet weak var countdownHoursLabel: UILabel!
    @IBOutlet weak var countdownMinutesLabel: UILabel!
    @IBOutlet weak var countdownSecondsLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var noAlarmScheduledLabel: UILabel!
    
    // MARK: - Properties
    
    var seconds = 0
    var countdownTimer = Timer()
    var isTimerRunning = true
    var currentTime = Date()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
        SoundManager.sharedInstance.stopSound()
        NotificationCenter.default.addObserver(self, selector: #selector(presentGame), name: NName(rawValue: "AlarmIsSounding"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadViewIfNeeded()
        SoundManager.sharedInstance.stopSound()
        guard AlarmController.sharedInstance.alarm != nil else { return }
        updateViews()
        
        // Testing Timer
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first,
            let daysOfWeek = alarm.daysOfWeek else { return }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            
            var notificationsArray: [UNNotificationRequest] = []
            
            for nextNotificationTest in notifications {
                notificationsArray.append(nextNotificationTest)
            }
            
            var notificationTriggerArray: [UNCalendarNotificationTrigger] = []
            
            for nextNotificationTriggerTest in notificationsArray {
                guard let triggerToAppend = nextNotificationTriggerTest.trigger as? UNCalendarNotificationTrigger else { return }
                notificationTriggerArray.append(triggerToAppend)
            }
            
            var nextTriggerDateArray: [Date] = []
            
            for nextTriggerDateTest in notificationTriggerArray {
                guard let triggerDateToAppend = nextTriggerDateTest.nextTriggerDate() else { return }
                nextTriggerDateArray.append(triggerDateToAppend)
            }
            
            if let closestDate = nextTriggerDateArray.sorted().first(where: {$0.timeIntervalSinceNow > 0}) {
                self.seconds = Int(closestDate.timeIntervalSince1970 - self.currentTime.timeIntervalSince1970)
            }
        }
        
        if daysOfWeek.count != 0 {
            self.runTimer()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countdownTimer.invalidate()
    }
    
    // MARK: - Actions
    
    @IBAction func privacyPolicyButtonTapped(_ sender: Any) {
        if let privacyPolicyURL = URL(string: "https://sites.google.com/view/antisnoozeprivacypolicy/home") {
            UIApplication.shared.open(privacyPolicyURL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func alarmToggleButtonTapped(_ sender: Any) {
        if let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first {
            
            if alarmToggleButton.isOn == true {
                alarm.isEnabled = true
                AlarmController.sharedInstance.scheduleAllNotifications()
                
            } else {
                alarm.isEnabled = false
                AlarmController.sharedInstance.removeNotifications()
                updateViews()
                countdownHoursLabel.isHidden = true
                countdownMinutesLabel.isHidden = true
                countdownSecondsLabel.isHidden = true
                hoursLabel.isHidden = true
                minutesLabel.isHidden = true
                secondsLabel.isHidden = true
                noAlarmScheduledLabel.isHidden = false
            }
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
        noAlarmScheduledLabel.isHidden = true
    }
    
    func updateViews() {
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first, let daysOfWeek = alarm.daysOfWeek, let alarmTimeAsString = alarm.alarmTimeAsString  {
            
            if daysOfWeek.count == 0 {
                alarm.isEnabled = false
                alarmToggleButton.isHidden = true
                sundayLabel.isHidden = true
                mondayLabel.isHidden = true
                tuesdayLabel.isHidden = true
                wednesdayLabel.isHidden = true
                thursdayLabel.isHidden = true
                fridayLabel.isHidden = true
                saturdayLabel.isHidden = true
                noAlarmScheduledLabel.isHidden = false
                countdownHoursLabel.isHidden = true
                countdownMinutesLabel.isHidden = true
                countdownSecondsLabel.isHidden = true
                hoursLabel.isHidden = true
                minutesLabel.isHidden = true
                secondsLabel.isHidden = true
            }
            
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
            // Alarm is nil
            alarmToggleButton.isHidden = true
            sundayLabel.isHidden = true
            mondayLabel.isHidden = true
            tuesdayLabel.isHidden = true
            wednesdayLabel.isHidden = true
            thursdayLabel.isHidden = true
            fridayLabel.isHidden = true
            saturdayLabel.isHidden = true
            countdownHoursLabel.isHidden = true
            countdownMinutesLabel.isHidden = true
            countdownSecondsLabel.isHidden = true
            hoursLabel.isHidden = true
            minutesLabel.isHidden = true
            secondsLabel.isHidden = true
            noAlarmScheduledLabel.isHidden = false
        }
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            if notifications.count == 0 {
                DispatchQueue.main.async {
                    self.alarmToggleButton.isHidden = true
                    self.sundayLabel.isHidden = true
                    self.mondayLabel.isHidden = true
                    self.tuesdayLabel.isHidden = true
                    self.wednesdayLabel.isHidden = true
                    self.thursdayLabel.isHidden = true
                    self.fridayLabel.isHidden = true
                    self.saturdayLabel.isHidden = true
                    self.countdownTimer.invalidate()
                }
            }
        }
    }
    
    // MARK: - Custom Methods
    
    @objc func presentGame() {
        // Create a random number
        var randomNumber = 1
        
        if Reachability.isConnectedToNetwork() {
            randomNumber = Int.random(in: 0...4)
        } else {
            randomNumber = Int.random(in: 1...4)
        }
        // Create an array of the view controller's identifier mini game names
        let arrayOfMiniGames = ["WordOfTheDayGame", "MemorizeNumberGame", "MathGame", "SquaresGame", "LeftBrainRightBrainGame"]
        
        goToViewController(withIdentifier: arrayOfMiniGames[randomNumber])
    }
    
    // Testing Timer
    func runTimer() {
        countdownTimer.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1
        
        if seconds >= 0 {
            let (hours, minutes, seconds) = secondsToHoursMinutesSeconds(seconds: self.seconds)
            
            let hoursString = String(format: "%02d", hours)
            let minutesString = String(format: "%02d", minutes)
            let secondsString = String(format: "%02d", seconds)
            self.countdownHoursLabel.text = hoursString
            self.countdownMinutesLabel.text = minutesString
            self.countdownSecondsLabel.text = secondsString
        } else {
            
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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

//
//  SetAlarmTableViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit

class SetAlarmTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var alarmValuePicker: UIDatePicker!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    
    // MARK: - Properties
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    var sundayButtonIsSelected = false
    var mondayButtonIsSelected = false
    var tuesdayButtonIsSelected = false
    var wednesdayButtonIsSelected = false
    var thursdayButtonIsSelected = false
    var fridayButtonIsSelected = false
    var saturdayButtonIsSelected = false
    
    var daysOfTheWeekSelected: [String] = AlarmController.sharedInstance.alarm?.daysOfWeek ?? []
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setsUpUI()
    }

    // MARK: - Actions
    
    @IBAction func alarmValuePickerValueChanged(_ sender: Any) {
//        print("Alarm Time changed to: \(alarmValuePicker.date)")
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = .short
//        dateFormatter.string(from: alarmValuePicker.date)
//        print("Formatted Alarm Time changed to: \(dateFormatter.string(from: alarmValuePicker.date))")
    }
    
    @IBAction func sundayButtonTapped(_ sender: Any) {
        print("Sunday Button Tapped")
        
        sundayButtonIsSelected.toggle()
        
        if sundayButtonIsSelected == true {
            sundayButton.backgroundColor = UIColor.blueAccent
            sundayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.sunday.rawValue)
        } else {
            sundayButton.backgroundColor = UIColor.darkBlue
            sundayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.sunday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func mondayButtonTapped(_ sender: Any) {
        print("Monday Button Tapped")
        
        mondayButtonIsSelected.toggle()
        
        if mondayButtonIsSelected == true {
            mondayButton.backgroundColor = UIColor.blueAccent
            mondayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.monday.rawValue)
        } else {
            mondayButton.backgroundColor = UIColor.darkBlue
            mondayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.monday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        print("Tuesday Button Tapped")
        
        tuesdayButtonIsSelected.toggle()
        
        if tuesdayButtonIsSelected == true {
            tuesdayButton.backgroundColor = UIColor.blueAccent
            tuesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.tuesday.rawValue)
        } else {
            tuesdayButton.backgroundColor = UIColor.darkBlue
            tuesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.tuesday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        print("Wednesday Button Tapped")
        
        wednesdayButtonIsSelected.toggle()
        
        if wednesdayButtonIsSelected == true {
            wednesdayButton.backgroundColor = UIColor.blueAccent
            wednesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.wednesday.rawValue)
        } else {
            wednesdayButton.backgroundColor = UIColor.darkBlue
            wednesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.wednesday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        print("Thursday Button Tapped")
        
        thursdayButtonIsSelected.toggle()
        
        if thursdayButtonIsSelected == true {
            thursdayButton.backgroundColor = UIColor.blueAccent
            thursdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.thursday.rawValue)
        } else {
            thursdayButton.backgroundColor = UIColor.darkBlue
            thursdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.thursday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func fridayButtonTapped(_ sender: Any) {
        print("Friday Button Tapped")
        
        fridayButtonIsSelected.toggle()
        
        if fridayButtonIsSelected == true {
            fridayButton.backgroundColor = UIColor.blueAccent
            fridayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.friday.rawValue)
        } else {
            fridayButton.backgroundColor = UIColor.darkBlue
            fridayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.friday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        print("Saturday Button Tapped")
        
        saturdayButtonIsSelected.toggle()
        
        if saturdayButtonIsSelected == true {
            saturdayButton.backgroundColor = UIColor.blueAccent
            saturdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.saturday.rawValue)
        } else {
            saturdayButton.backgroundColor = UIColor.darkBlue
            saturdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.saturday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let alarm = alarm {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, alarmTime: alarmValuePicker.date, daysOfWeek: daysOfTheWeekSelected, alarmSound: "default", alarmVolume: 1, isEnabled: true)
        } else {
            AlarmController.sharedInstance.createAlarm(alarmTime: alarmValuePicker.date, daysOfWeek: daysOfTheWeekSelected, alarmSound: "default", alarmVolume: 1)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: - Custom Methods

    func setsUpUI() {
        // Changes the alarm color picker color to white
        alarmValuePicker.setValue(UIColor.white, forKey: "textColor")
        
        // Changes the days of the week buttons to be circles
        sundayButton.layer.cornerRadius = sundayButton.frame.height / 2
        mondayButton.layer.cornerRadius = mondayButton.frame.height / 2
        tuesdayButton.layer.cornerRadius = tuesdayButton.frame.height / 2
        wednesdayButton.layer.cornerRadius = wednesdayButton.frame.height / 2
        thursdayButton.layer.cornerRadius = thursdayButton.frame.height / 2
        fridayButton.layer.cornerRadius = fridayButton.frame.height / 2
        saturdayButton.layer.cornerRadius = saturdayButton.frame.height / 2
    }
   
    func updateViews() {
        guard let alarm = alarm else { return }
        loadViewIfNeeded()
        
        alarmValuePicker.date = alarm.alarmTime
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.sunday.rawValue) {
            sundayButton.backgroundColor = UIColor.blueAccent
            sundayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            sundayButtonIsSelected = true
        } else {
            sundayButton.backgroundColor = UIColor.darkBlue
            sundayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            sundayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.monday.rawValue) {
            mondayButton.backgroundColor = UIColor.blueAccent
            mondayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            mondayButtonIsSelected = true
        } else {
            mondayButton.backgroundColor = UIColor.darkBlue
            mondayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            mondayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.tuesday.rawValue) {
            tuesdayButton.backgroundColor = UIColor.blueAccent
            tuesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            tuesdayButtonIsSelected = true
        } else {
            tuesdayButton.backgroundColor = UIColor.darkBlue
            tuesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            tuesdayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.wednesday.rawValue) {
            wednesdayButton.backgroundColor = UIColor.blueAccent
            wednesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            wednesdayButtonIsSelected = true
        } else {
            wednesdayButton.backgroundColor = UIColor.darkBlue
            wednesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            wednesdayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.thursday.rawValue) {
            thursdayButton.backgroundColor = UIColor.blueAccent
            thursdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            thursdayButtonIsSelected = true
        } else {
            thursdayButton.backgroundColor = UIColor.darkBlue
            thursdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            thursdayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.friday.rawValue) {
            fridayButton.backgroundColor = UIColor.blueAccent
            fridayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            fridayButtonIsSelected = true
        } else {
            fridayButton.backgroundColor = UIColor.darkBlue
            fridayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            fridayButtonIsSelected = false
        }
        
        if alarm.daysOfWeek.contains(Alarm.daysOfWeek.saturday.rawValue) {
            saturdayButton.backgroundColor = UIColor.blueAccent
            saturdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
            saturdayButtonIsSelected = true
        } else {
            saturdayButton.backgroundColor = UIColor.darkBlue
            saturdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            saturdayButtonIsSelected = false
        }
        
//        if fridayButtonIsSelected == true {
//            fridayButton.backgroundColor = UIColor.blueAccent
//            fridayButton.setTitleColor(UIColor.darkBlue, for: .normal)
//            //            daysOfTheWeekSelected.append(Alarm.daysOfWeek.friday.rawValue)
//        }
    }

} // End of class

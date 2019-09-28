//
//  SetAlarmTableViewController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/10/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import UserNotifications
import MediaPlayer

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
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    @IBOutlet weak var soundPickerView: UIPickerView!
    
    
    // MARK: - Properties
    
    var alarms: [Alarm]? {
        didSet {
            updateViews()
        }
    }
    
    var selectedSound = "Sonar"
    
    var sundayButtonIsSelected = false
    var mondayButtonIsSelected = false
    var tuesdayButtonIsSelected = false
    var wednesdayButtonIsSelected = false
    var thursdayButtonIsSelected = false
    var fridayButtonIsSelected = false
    var saturdayButtonIsSelected = false
    
    var daysOfTheWeekSelected: [String] = AlarmController.sharedInstance.alarm?.first?.daysOfWeek ?? []
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(returnToMainScreen))
        soundPickerView.delegate = self
        soundPickerView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setsUpUI()
    }
    
    // MARK: - Actions

    @objc func volumeSliderValuedChanged() {
        SoundManager.sharedInstance.stopSound()
        SoundManager.sharedInstance.playSoundOnce(withVolume: volumeSlider.value, alarmSound: selectedSound)
    }
    
    @IBAction func sundayButtonTapped(_ sender: Any) {
        sundayButtonIsSelected.toggle()
        
        if sundayButtonIsSelected == true {
            sundayButton.backgroundColor = UIColor.blueAccent
            sundayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.sunday.rawValue)
        } else {
            sundayButton.backgroundColor = UIColor.darkColor
            sundayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.sunday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func mondayButtonTapped(_ sender: Any) {
        mondayButtonIsSelected.toggle()
        
        if mondayButtonIsSelected == true {
            mondayButton.backgroundColor = UIColor.blueAccent
            mondayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.monday.rawValue)
        } else {
            mondayButton.backgroundColor = UIColor.darkColor
            mondayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.monday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        tuesdayButtonIsSelected.toggle()
        
        if tuesdayButtonIsSelected == true {
            tuesdayButton.backgroundColor = UIColor.blueAccent
            tuesdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.tuesday.rawValue)
        } else {
            tuesdayButton.backgroundColor = UIColor.darkColor
            tuesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.tuesday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        wednesdayButtonIsSelected.toggle()
        
        if wednesdayButtonIsSelected == true {
            wednesdayButton.backgroundColor = UIColor.blueAccent
            wednesdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.wednesday.rawValue)
        } else {
            wednesdayButton.backgroundColor = UIColor.darkColor
            wednesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.wednesday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        thursdayButtonIsSelected.toggle()
        
        if thursdayButtonIsSelected == true {
            thursdayButton.backgroundColor = UIColor.blueAccent
            thursdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.thursday.rawValue)
        } else {
            thursdayButton.backgroundColor = UIColor.darkColor
            thursdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.thursday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func fridayButtonTapped(_ sender: Any) {
        fridayButtonIsSelected.toggle()
        
        if fridayButtonIsSelected == true {
            fridayButton.backgroundColor = UIColor.blueAccent
            fridayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.friday.rawValue)
        } else {
            fridayButton.backgroundColor = UIColor.darkColor
            fridayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.friday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        saturdayButtonIsSelected.toggle()
        
        if saturdayButtonIsSelected == true {
            saturdayButton.backgroundColor = UIColor.blueAccent
            saturdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            daysOfTheWeekSelected.append(Alarm.daysOfWeek.saturday.rawValue)
        } else {
            saturdayButton.backgroundColor = UIColor.darkColor
            saturdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            if let dayToRemove = daysOfTheWeekSelected.firstIndex(of: Alarm.daysOfWeek.saturday.rawValue) {
                daysOfTheWeekSelected.remove(at: dayToRemove)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if let alarms = AlarmController.sharedInstance.alarm, let alarm = alarms.first {
            AlarmController.sharedInstance.updateAlarm(alarm: alarm, alarmTime: alarmValuePicker.date, daysOfWeek: daysOfTheWeekSelected, alarmSound: selectedSound, alarmVolume: self.volumeSlider.value, isEnabled: true)
            AlarmController.sharedInstance.removeNotifications()
        } else {
            AlarmController.sharedInstance.createAlarm(alarmTime: alarmValuePicker.date, daysOfWeek: daysOfTheWeekSelected, alarmSound: selectedSound, alarmVolume: self.volumeSlider.value)
            AlarmController.sharedInstance.removeNotifications()
        }
        
        AlarmController.sharedInstance.scheduleAllNotifications()
        MPVolumeView.setVolume(self.volumeSlider.value)
        SoundManager.sharedInstance.stopSound()
        
        if daysOfTheWeekSelected.count == 0 {
            presentAlarmNotActiveAlert()
        }
        
        if daysOfTheWeekSelected.count == 1 {
            presentAlarmWontRepeatAlert()
        }
        
        let alarmTime = alarmValuePicker.date.stringWith(timeStyle: .short).components(separatedBy: [":", " "])

        let AMorPM = alarmTime[2]
        
        if AMorPM == "PM" {
            presentSelectedPMAlert()
        }

        goToViewController(withIdentifier: "mainNavigationController")
    }
    
    // MARK: - UI Adjustments
    
    func setsUpUI() {
        
        tableView.backgroundColor = UIColor.darkColor
        
        // Changes the alarm color picker text color and bg color
        alarmValuePicker.setValue(UIColor.white, forKey: "textColor")
        alarmValuePicker.backgroundColor = UIColor.darkColor
        
        // Changes UISlider
        volumeSlider.isContinuous = false
        volumeSlider.addTarget(self, action: #selector(volumeSliderValuedChanged), for: .valueChanged)
        volumeSlider.minimumTrackTintColor = UIColor.blueAccent
        
        // Changes the days of the week buttons to be circles
        sundayButton.layer.cornerRadius = sundayButton.frame.height / 2
        mondayButton.layer.cornerRadius = mondayButton.frame.height / 2
        tuesdayButton.layer.cornerRadius = tuesdayButton.frame.height / 2
        wednesdayButton.layer.cornerRadius = wednesdayButton.frame.height / 2
        thursdayButton.layer.cornerRadius = thursdayButton.frame.height / 2
        fridayButton.layer.cornerRadius = fridayButton.frame.height / 2
        saturdayButton.layer.cornerRadius = saturdayButton.frame.height / 2
        
        // Stylize Picker View
        soundPickerView.backgroundColor = UIColor.darkColor
        soundPickerView.setValue(UIColor.mainTextColor, forKey: "textColor")
    }
    
    func updateViews() {
        guard let alarms = alarms, let alarm = alarms.first, let alarmTime = alarm.alarmTime, let daysOfWeek = alarm.daysOfWeek, let alarmSound = alarm.alarmSound else { return }
        
        loadViewIfNeeded()
        
        alarmValuePicker.date = alarmTime
        volumeSlider.value = alarm.alarmVolume
        
        if daysOfWeek.contains(Alarm.daysOfWeek.sunday.rawValue) {
            sundayButton.backgroundColor = UIColor.blueAccent
            sundayButton.setTitleColor(UIColor.darkColor, for: .normal)
            sundayButtonIsSelected = true
        } else {
            sundayButton.backgroundColor = UIColor.darkColor
            sundayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            sundayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.monday.rawValue) {
            mondayButton.backgroundColor = UIColor.blueAccent
            mondayButton.setTitleColor(UIColor.darkColor, for: .normal)
            mondayButtonIsSelected = true
        } else {
            mondayButton.backgroundColor = UIColor.darkColor
            mondayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            mondayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.tuesday.rawValue) {
            tuesdayButton.backgroundColor = UIColor.blueAccent
            tuesdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            tuesdayButtonIsSelected = true
        } else {
            tuesdayButton.backgroundColor = UIColor.darkColor
            tuesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            tuesdayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.wednesday.rawValue) {
            wednesdayButton.backgroundColor = UIColor.blueAccent
            wednesdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            wednesdayButtonIsSelected = true
        } else {
            wednesdayButton.backgroundColor = UIColor.darkColor
            wednesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            wednesdayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.thursday.rawValue) {
            thursdayButton.backgroundColor = UIColor.blueAccent
            thursdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            thursdayButtonIsSelected = true
        } else {
            thursdayButton.backgroundColor = UIColor.darkColor
            thursdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            thursdayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.friday.rawValue) {
            fridayButton.backgroundColor = UIColor.blueAccent
            fridayButton.setTitleColor(UIColor.darkColor, for: .normal)
            fridayButtonIsSelected = true
        } else {
            fridayButton.backgroundColor = UIColor.darkColor
            fridayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            fridayButtonIsSelected = false
        }
        
        if daysOfWeek.contains(Alarm.daysOfWeek.saturday.rawValue) {
            saturdayButton.backgroundColor = UIColor.blueAccent
            saturdayButton.setTitleColor(UIColor.darkColor, for: .normal)
            saturdayButtonIsSelected = true
        } else {
            saturdayButton.backgroundColor = UIColor.darkColor
            saturdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
            saturdayButtonIsSelected = false
        }
        
        var alarmIndex = 0
        
        switch alarmSound {
        case "Sonar":
            alarmIndex = 0
        case "Magical":
            alarmIndex = 1
        case "Doorbell":
            alarmIndex = 2
        case "Thunder":
            alarmIndex = 3
        case "SciFi":
            alarmIndex = 4
        case "Drum":
            alarmIndex = 5
        case "Old Fashion Alarm Clock":
            alarmIndex = 6
        default:
            // Alarm sound not found so revert to default
            alarmIndex = 0
        }
        
        soundPickerView.selectRow(alarmIndex, inComponent: 0, animated: true)
        selectedSound = AlarmController.sharedInstance.sounds[alarmIndex]
    }
    
    // MARK: - Custom Methods
    
    @objc func returnToMainScreen() {
        SoundManager.sharedInstance.stopSound()
        goToViewController(withIdentifier: "mainNavigationController")
    }
} // End of class

// MARK: - Extensions

extension SetAlarmTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AlarmController.sharedInstance.sounds.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedSound = AlarmController.sharedInstance.sounds[row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sound = AlarmController.sharedInstance.sounds[row]
        return sound
    }
}

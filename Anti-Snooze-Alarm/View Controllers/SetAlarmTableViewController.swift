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
    
    var alarmValue: Date?
    
    var sundayButtonIsSelected = false
    var mondayButtonIsSelected = false
    var tuesdayButtonIsSelected = false
    var wednesdayButtonIsSelected = false
    var thursdayButtonIsSelected = false
    var fridayButtonIsSelected = false
    var saturdayButtonIsSelected = false

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setsUpUI()
    }

    // MARK: - Actions
    
    @IBAction func alarmValuePickerValueChanged(_ sender: Any) {
        print("Alarm Time changed to: \(alarmValuePicker.date)")
    }
    
    @IBAction func sundayButtonTapped(_ sender: Any) {
        print("Sunday Button Tapped")
        
        sundayButtonIsSelected.toggle()
        
        if sundayButtonIsSelected == true {
            sundayButton.backgroundColor = UIColor.blueAccent
            sundayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            sundayButton.backgroundColor = UIColor.darkBlue
            sundayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func mondayButtonTapped(_ sender: Any) {
        print("Monday Button Tapped")
        
        mondayButtonIsSelected.toggle()
        
        if mondayButtonIsSelected == true {
            mondayButton.backgroundColor = UIColor.blueAccent
            mondayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            mondayButton.backgroundColor = UIColor.darkBlue
            mondayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        print("Tuesday Button Tapped")
        
        tuesdayButtonIsSelected.toggle()
        
        if tuesdayButtonIsSelected == true {
            tuesdayButton.backgroundColor = UIColor.blueAccent
            tuesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            tuesdayButton.backgroundColor = UIColor.darkBlue
            tuesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        print("Wednesday Button Tapped")
        
        wednesdayButtonIsSelected.toggle()
        
        if wednesdayButtonIsSelected == true {
            wednesdayButton.backgroundColor = UIColor.blueAccent
            wednesdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            wednesdayButton.backgroundColor = UIColor.darkBlue
            wednesdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        print("Thursday Button Tapped")
        
        thursdayButtonIsSelected.toggle()
        
        if thursdayButtonIsSelected == true {
            thursdayButton.backgroundColor = UIColor.blueAccent
            thursdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            thursdayButton.backgroundColor = UIColor.darkBlue
            thursdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func fridayButtonTapped(_ sender: Any) {
        print("Friday Button Tapped")
        
        fridayButtonIsSelected.toggle()
        
        if fridayButtonIsSelected == true {
            fridayButton.backgroundColor = UIColor.blueAccent
            fridayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            fridayButton.backgroundColor = UIColor.darkBlue
            fridayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
    }
    
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        print("Saturday Button Tapped")
        
        saturdayButtonIsSelected.toggle()
        
        if saturdayButtonIsSelected == true {
            saturdayButton.backgroundColor = UIColor.blueAccent
            saturdayButton.setTitleColor(UIColor.darkBlue, for: .normal)
        } else {
            saturdayButton.backgroundColor = UIColor.darkBlue
            saturdayButton.setTitleColor(UIColor.mainTextColor, for: .normal)
        }
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
   

} // End of class

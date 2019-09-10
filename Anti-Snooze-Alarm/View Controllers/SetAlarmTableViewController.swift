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
            sundayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            sundayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            sundayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            sundayButton.setTitleColor(UIColor.white, for: .normal)
        }
        
    }
    
    @IBAction func mondayButtonTapped(_ sender: Any) {
        print("Monday Button Tapped")
        
        mondayButtonIsSelected.toggle()
        
        if mondayButtonIsSelected == true {
            mondayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            mondayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            mondayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            mondayButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func tuesdayButtonTapped(_ sender: Any) {
        print("Tuesday Button Tapped")
        
        tuesdayButtonIsSelected.toggle()
        
        if tuesdayButtonIsSelected == true {
            tuesdayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            tuesdayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            tuesdayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            tuesdayButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func wednesdayButtonTapped(_ sender: Any) {
        print("Wednesday Button Tapped")
        
        wednesdayButtonIsSelected.toggle()
        
        if wednesdayButtonIsSelected == true {
            wednesdayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            wednesdayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            wednesdayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            wednesdayButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func thursdayButtonTapped(_ sender: Any) {
        print("Thursday Button Tapped")
        
        thursdayButtonIsSelected.toggle()
        
        if thursdayButtonIsSelected == true {
            thursdayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            thursdayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            thursdayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            thursdayButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func fridayButtonTapped(_ sender: Any) {
        print("Friday Button Tapped")
        
        fridayButtonIsSelected.toggle()
        
        if fridayButtonIsSelected == true {
            fridayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            fridayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            fridayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            fridayButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func saturdayButtonTapped(_ sender: Any) {
        print("Saturday Button Tapped")
        
        saturdayButtonIsSelected.toggle()
        
        if saturdayButtonIsSelected == true {
            saturdayButton.backgroundColor = #colorLiteral(red: 0.1596083343, green: 0.627512455, blue: 0.8221227527, alpha: 1)
            saturdayButton.setTitleColor(UIColor.init(red: 28.0/255.0, green: 53.0/255.0, blue: 75.0/255.0, alpha: 1.0), for: .normal)
        } else {
            saturdayButton.backgroundColor = #colorLiteral(red: 0.07138665766, green: 0.2125675678, blue: 0.3019170761, alpha: 1)
            saturdayButton.setTitleColor(UIColor.white, for: .normal)
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
   

}

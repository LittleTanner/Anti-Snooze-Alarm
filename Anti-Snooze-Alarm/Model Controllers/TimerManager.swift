//
//  TimerManager.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 11/12/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class TimerManager {
    
    static let sharedInstance = TimerManager()
    
    var soundCountdownTimer = Timer()
    
    func runTimer() {
        guard let durationOfSound = SoundManager.sharedInstance.audioPlayer?.duration else { return }
        soundCountdownTimer.invalidate()
        soundCountdownTimer = Timer.scheduledTimer(timeInterval: durationOfSound + 10, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if !ViewManager.sharedInstance.alarmIsSounding {
            soundCountdownTimer.invalidate()
            return
        }
        
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first,
            let alarmSound = alarm.alarmSound else { return }
        
        SoundManager.sharedInstance.playSoundOnce(withVolume: alarm.alarmVolume, alarmSound: alarmSound)
    }
    
    func invalidateTimer() {
        soundCountdownTimer.invalidate()
    }
    
}

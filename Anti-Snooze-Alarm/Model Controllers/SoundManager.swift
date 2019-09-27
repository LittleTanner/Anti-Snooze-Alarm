//
//  SoundManager.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/24/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

// List of system Sounds https://github.com/TUNER88/iOSSystemSoundsLibrary

class SoundManager {
    
    static let sharedInstance = SoundManager()
    
    var audioPlayer: AVAudioPlayer?
    
    
    func playRepeatingSound(withVolume volume: Float) {
        guard let alarms = AlarmController.sharedInstance.alarm,
        let alarm = alarms.first,
        let alarmSound = alarm.alarmSound else { return }
        
        guard let url = Bundle.main.url(forResource: alarmSound, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: "mp3")

            guard let audioPlayer = audioPlayer else { return }
            
            print("Output Volume: \(AVAudioSession.sharedInstance().outputVolume)")
            
            MPVolumeView.setVolume(volume)
            
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSoundOnce(withVolume volume: Float, alarmSound: String) {

        guard let url = Bundle.main.url(forResource: alarmSound, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: "mp3")

            guard let audioPlayer = audioPlayer else { return }
            
            print("Output Volume: \(AVAudioSession.sharedInstance().outputVolume)")
            
            MPVolumeView.setVolume(volume)
            
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
    func pauseSound() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.pause()
    }
} // End of class




extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        // Need to use the MPVolumeView in order to change volume, but don't care about UI set so frame to .zero
        let volumeView = MPVolumeView(frame: .zero)
        // Search for the slider
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        // Update the slider value with the desired volume.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
        // Optional - Remove the HUD
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            volumeView.alpha = 0.000001
            window.addSubview(volumeView)
        }
    }
}

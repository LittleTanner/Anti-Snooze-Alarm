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
    
//    // To play system sounds
//    func playSound(withVolume volume: Float) {
//        let soundURL = NSURL(fileURLWithPath: "/System/Library/Audio/UISounds/ReceivedMessage.caf")
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL, fileTypeHint: "caf")
//
//            guard let audioPlayer = audioPlayer else { return }
//
//
//            print("Output Volume: \(AVAudioSession.sharedInstance().outputVolume)")
//
//            audioPlayer.volume = volume
//            audioPlayer.numberOfLoops = -1
//            audioPlayer.play()
//
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
    
    func playSound(withVolume volume: Float) {
        
        guard let url = Bundle.main.url(forResource: "Birds", withExtension: "caf") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: "caf")

            guard let audioPlayer = audioPlayer else { return }
            
            print("Output Volume: \(AVAudioSession.sharedInstance().outputVolume)")
            
            audioPlayer.volume = volume
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        guard let audioPlayer = audioPlayer else { return }
        
        audioPlayer.stop()
    }
} // End of class




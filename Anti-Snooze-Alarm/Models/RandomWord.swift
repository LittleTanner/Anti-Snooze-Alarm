//
//  RandomWord.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

struct RandomWord: Decodable {
    let word: String?
    
    init(word: String) {
        self.word = word
    }
}

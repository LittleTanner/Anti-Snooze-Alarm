//
//  Word.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class Word: Decodable {
    let word: String?
    var definition: String?
    
    init(wordObject: FirstWordInArray) {
        self.word = wordObject.word
        self.definition = wordObject.definitions.first
    }
}

struct FirstWordInArray: Decodable {
    enum CodingKeys: String, CodingKey {
        case word
        case definitions = "defs"
    }
    
    let word: String
    let definitions: [String]
}

struct DefinitionOfWord: Decodable {
    enum CodingKeys: Int, CodingKey {
        case firstDefinition = 0
    }
    
    let firstDefinition: String
}

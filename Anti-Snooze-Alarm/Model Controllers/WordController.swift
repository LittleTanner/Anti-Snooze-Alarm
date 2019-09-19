//
//  WordController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class WordController {
    
    // Fetch
    
    // URL to create
    // https://api.datamuse.com/words?sp=flower&md=d&max=1
    func fetchWordOfTheDay(word: String, completion: @escaping (Word?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.datamuse.com/words") else {
            completion(nil)
            return
        }
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            print("Our URL is not working right. In function: \(#function)")
            completion(nil)
            return
        }
        
        let wordQueryItem = URLQueryItem(name: "sp", value: word)
        let definitionQueryItem = URLQueryItem(name: "md", value: "d")
        let limitToOneWordQueryItem = URLQueryItem(name: "max", value: "1")
        
        components.queryItems = [wordQueryItem, definitionQueryItem, limitToOneWordQueryItem]
        
        guard let builtURL = components.url else {
            print("Our query items are causing trouble in function: \(#function)")
            completion(nil)
            return
        }
        
        
        print("The builtURL is: \(builtURL)")
        
        let dataTask = URLSession.shared.dataTask(with: builtURL) { (data, response, error) in
            if let error = error {
                print("There was an error with the url in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //            if let response = response {
            //                print("The response from Weather was: \(response)")
            //            }
            
            guard let data = data else {
                print("There was no word data found in \(#function).")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let wordObject = try jsonDecoder.decode([FirstWordInArray].self, from: data)
                if let word = wordObject.first {
                    completion(Word(wordObject: word))
                }
            } catch {
                print("There was an error decoding Word JSON in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    
}

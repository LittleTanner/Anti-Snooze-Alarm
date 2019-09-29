//
//  RandomWordController.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/19/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation

class RandomWordController {
    
    // URL to create
    // https://random-word-api.herokuapp.com/word?key=WMDFHP4S&number=1
    
    func fetchRandomWord(completion: @escaping (String?) -> Void) {
        
        guard let baseURL = URL(string: "https://random-word-api.herokuapp.com/word") else {
            completion(nil)
            return
        }
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
            print("Our URL is not working right. In function: \(#function)")
            completion(nil)
            return
        }
        
        let apiKey = "Q5QLDBOR"
        
        let apiKeyQueryItem = URLQueryItem(name: "key", value: apiKey)
        let numberOfWordsReturnedQueryItem = URLQueryItem(name: "number", value: "1")
        
        components.queryItems = [apiKeyQueryItem, numberOfWordsReturnedQueryItem]
        
        guard let builtURL = components.url else {
            print("Our query items are causing trouble in function: \(#function)")
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest(url: builtURL)
        urlRequest.httpMethod = "GET"
        
        
//        print("The builtURL is: \(builtURL)")
//        print("The urlRequestURL is : \(urlRequest)")
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("There was an error with the url in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            //            if let response = response {
            //                print("The response from Weather was: \(response)")
            //            }
            
            guard let data = data else {
                print("There was no random word data found in \(#function).")
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let randomWordObject = try jsonDecoder.decode([String].self, from: data)
                if let randomWord = randomWordObject.first {
                    completion(randomWord)
                }
            } catch {
                print("There was an error decoding random word JSON in \(#function). \n Error: \(error), \n Error Localized Description: \(error.localizedDescription)")
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
}

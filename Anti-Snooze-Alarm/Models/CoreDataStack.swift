//
//  CoreDataStack.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/16/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Anti_Snooze_Alarm")
        
        container.loadPersistentStores() { (storeDescription, error) in
           
            if let error = error as NSError? {
                fatalError("Unresolved error in \(#function), error: \(error), error localized description: \(error.localizedDescription)")
            }
        }
        return container
        }()
    
    static var context: NSManagedObjectContext { return container.viewContext}
}

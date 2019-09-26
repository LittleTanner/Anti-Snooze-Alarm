//
//  AppDelegate.swift
//  Anti-Snooze-Alarm
//
//  Created by Kevin Tanner on 9/9/19.
//  Copyright © 2019 Kevin Tanner. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import AVKit
import MediaPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
//    var countdownTimer = Timer()
//    var timeUntilAlarm: Double = 10.0



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Request authorization to send notifications, This might need to be assigned to a variable for storage.. not sure yet
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, /*.sound, */.badge]) { (success, error) in
            // Check for error
            if let error = error {
                print("There was an error in \(#function), error: \(error), error localized description: \(error.localizedDescription)")
            }
            
            // Check for success
            if success {
                print("Permission to send notifications granted")
            } else {
                print("Denied permission to send notifications")
            }
        }

        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Create an instance of the main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Create a random number
        let randomNumber = Int.random(in: 0...4)

        // Create an instance of the view controller
        switch randomNumber {
        case 0:
            if let controller = storyboard.instantiateViewController(withIdentifier: "MemorizeNumberGame") as? MemorizeNumberViewController {
                self.window?.rootViewController = controller
            }
        case 1:
            if let controller = storyboard.instantiateViewController(withIdentifier: "WordOfTheDayGame") as? WordOfTheDayViewController {
                self.window?.rootViewController = controller
            }
        case 2:
            if let controller = storyboard.instantiateViewController(withIdentifier: "MathGame") as? MathViewController {
                self.window?.rootViewController = controller
            }
        case 3:
            if let controller = storyboard.instantiateViewController(withIdentifier: "SquaresGame") as? SquaresViewController {
                self.window?.rootViewController = controller
            }
        case 4:
            if let controller = storyboard.instantiateViewController(withIdentifier: "LeftBrainRightBrainGame") as? LeftBrainRightBrainViewController {
                self.window?.rootViewController = controller
            }
        default:
            if let controller = storyboard.instantiateViewController(withIdentifier: "mainNavigationController") as? MainNavigationViewController {
                self.window?.rootViewController = controller
            }
            print("User clicked on local notification. There was an error sending user to random game so sent them to the main page")
        }
        
        completionHandler()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification sent")
        
        guard let alarms = AlarmController.sharedInstance.alarm,
            let alarm = alarms.first,
            let alarmTime = alarm.alarmTimeAsString else { return }
        SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
        print("AppDelegate AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
        
        
        
        // Testing to create notifications on the fly
        
//        let currentTime = Date().stringWith(timeStyle: .short)
//
//        var numberOfNotificationsScheduled = 0
//        print(numberOfNotificationsScheduled)
//
//        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
//            numberOfNotificationsScheduled = notifications.count
//            print("Pending notifications scheduled: \(notifications.count)")
//            if currentTime == alarmTime && (notifications.count > 0) {
//                SoundManager.sharedInstance.playRepeatingSound(withVolume: alarm.alarmVolume)
//                print("AppDelegate AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
//            } else {
//                SoundManager.sharedInstance.audioPlayer?.stop()
//                print("AppDelegate AudioPlayer is set too: \(String(describing: SoundManager.sharedInstance.audioPlayer?.isPlaying))")
//            }
//        }
//        print(numberOfNotificationsScheduled)
//        print("currentTime: \(currentTime)")
//        print("alarmTime: \(alarmTime)")
        
        
        
        // removed alert/sound/badge from showing in the app, need to have some way for them to get to the mini game from the home screen if they open the app directly and don't click on a notification.
        completionHandler([/*.alert, .sound, .badge*/])
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Anti_Snooze_Alarm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving Support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

} // End of class

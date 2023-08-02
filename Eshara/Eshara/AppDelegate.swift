//
//  AppDelegate.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 01/08/2023.
//

import UIKit
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


    private let remindActionID = "RemindAction"
    private let markAsPaidActionID = "MarkAsPaidAction"
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        guard var alert = Database.shared.getAlert(notificationID: id) else { completionHandler(); return }
        
        switch response.actionIdentifier {
            
        case remindActionID:
            
            let newRemindDate = Date().addingTimeInterval(60 * 60 * 24)
            
            //compare to break the reminder
            
            alert.scheduleReminder(on: newRemindDate) { (updatedAlert) in
                Database.shared.updateAndSave(updatedAlert)
            }
            
        case markAsPaidActionID:
            alert.paidDate = Date()
            Database.shared.updateAndSave(alert)
            
        default:
            break
        }
        
        completionHandler()
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let remindAction = UNNotificationAction(identifier: remindActionID, title: "Remind me later", options: [])
        let markAsPaidAction = UNNotificationAction(identifier: markAsPaidActionID, title: "Mark as paid", options: [.authenticationRequired])
        
        let category = UNNotificationCategory(identifier: Notify.notificationCategoryID, actions: [remindAction, markAsPaidAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


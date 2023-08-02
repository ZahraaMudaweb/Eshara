//
//  NotifyExtra.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//


import Foundation
import UserNotifications

extension Notify {
    
    static let notificationCategoryID = "ReminderNotifications"
    
    var hasReminder: Bool {
        return (remindDate != nil)
    }
    
    var isPaid: Bool {
        return (paidDate != nil)
    }
    
    var formattedDueDate: String {
        let dateString: String
        
        if let dueDate = self.dueDate {
            dateString = dueDate.formatted(date: .numeric, time: .omitted)
        } else {
            dateString = ""
        }
        
        return dateString
    }
        
    mutating func removeReminder() {
        if let id = notificationID {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
            notificationID = nil
            remindDate = nil
        }
    }
    
    private func authorizeIfNeeded(completion: @escaping (Bool) -> ()) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                completion(true)
                
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: { (granted, _) in
                    completion(granted)
                })
                
            case .ephemeral:
                // only available to app clips
                completion(false)
                
            case .denied:
                completion(false)
                
            @unknown default:
                completion(false)
            }
        }
    }

    mutating func scheduleReminder(on date: Date, completion: @escaping (Notify) ->()) {
        var updatedAlert = self
        
        updatedAlert.removeReminder()
        
        authorizeIfNeeded { (granted) in
            guard granted else {
                DispatchQueue.main.async {
                    completion(updatedAlert)
                }
                
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Bill Reminder"
            content.body = String(format: "%@ due to %@ on %@", arguments: [(updatedAlert.amount ?? 0).formatted(.currency(code: "usd")), (updatedAlert.payee ?? ""), updatedAlert.formattedDueDate])
            content.categoryIdentifier = Notify.notificationCategoryID
            content.sound = UNNotificationSound.default
            
            let triggerDateComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
            
            let notificationID = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        updatedAlert.notificationID = notificationID
                        updatedAlert.remindDate = date
                    }
                    DispatchQueue.main.async {
                        completion(updatedAlert)
                    }
                }
            })
        }
    }

}

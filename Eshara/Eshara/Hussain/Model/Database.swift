//
//  Database.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import Foundation
import UIKit

class Database {
    
    static let UpdatedNotification = NSNotification.Name("com.apple.BillManager.billUpdated")

    static let shared = Database()
        
    private func loadNotifications() -> [UUID:Notify]? {
        var AllNotifications = [UUID:Notify]()
        
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let storageURL = storageDirectory.appendingPathComponent("bills").appendingPathExtension("json")
            
            let fileData = try Data(contentsOf: storageURL)
            let NotifyArray = try JSONDecoder().decode([Notify].self, from: fileData)
           
            AllNotifications = NotifyArray.reduce(into: AllNotifications) { partial, notf in
                partial[notf.id] = notf
            }
            
        } catch {
            return nil
        }
        
        return AllNotifications
    }
    
    private func saveNotifications(_ Alerts: [UUID:Notify]) {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("bills").appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(Array(Alerts.values))
            
            try fileData.write(to: storageURL)
            
        } catch {
            fatalError("There was a problem saving alerts. Error: \(error)")
        }
    }
    
    private var _AlertsOptional: [UUID:Notify]?
    
    private var _AlertsLookup: [UUID:Notify] {
        get {
            if _AlertsOptional == nil {
                _AlertsOptional = loadNotifications() ?? [:]
            }
            
            return _AlertsOptional!
        }
        set {
            _AlertsOptional = newValue
        }
    }
    
    var Alerts: [Notify] {
        get {
            return Array(_AlertsLookup.values.sorted(by: <))
        }
    }
    
    func addAlert() -> Notify {
        let alert = Notify()
        _AlertsLookup[alert.id] = alert
        return alert
    }
    
    func updateAndSave(_ alert: Notify) {
        _AlertsLookup[alert.id] = alert
        save()
        
        NotificationCenter.default.post(name: Self.UpdatedNotification, object: nil)
    }
        
    func save() {
        saveNotifications(_AlertsLookup)
    }
    
    func delete(alert: Notify) {
        _AlertsLookup[alert.id] = nil
    }
    
    func getAlert(withID id: UUID) -> Notify? {
        return _AlertsLookup[id]
    }
    
    func getAlert(notificationID: String) -> Notify? {
        guard let keyValue = _AlertsLookup.first(where: { $0.value.notificationID == notificationID }) else { return nil }
        
        return keyValue.value
    }
}

extension Notify: Comparable {
    static func < (lhs: Notify, rhs: Notify) -> Bool {
        func compareAmounts(_ l: Notify, _ r: Notify) -> Bool {
            switch (l.amount, r.amount) {
            case (let l?, let r?):
                return l > r
            case (nil, .some(_)):
                return false
            case (.some(_), nil):
                return true
            case (nil, nil):
                return lhs.id.uuidString < rhs.id.uuidString
            }
        }
        
        switch (lhs.dueDate, rhs.dueDate) {
        case (let l?, let r?):
            let result = Calendar.current.compare(l, to: r, toGranularity: .day)
            if result == .orderedSame {
                return compareAmounts(lhs, rhs)
            } else {
                return result == .orderedAscending
            }
        case (nil, .some(_)):
            return false
        case (.some(_), nil):
            return true
        case (nil, nil):
            return compareAmounts(lhs, rhs)
        }
    }
}


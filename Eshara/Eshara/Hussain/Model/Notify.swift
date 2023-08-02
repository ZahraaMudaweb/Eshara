//
//  Reminder.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//


import Foundation

struct Notify: Codable {
    let id: UUID
    var amount: Double?
    var dueDate: Date?
    var notificationID: String?
    var paidDate: Date?
    var payee: String?
    var remindDate: Date?
    
    init(id: UUID = UUID()) {
        self.id = id
    }
}

extension Notify: Hashable {
//    static func ==(_ lhs: Bill, _ rhs: Bill) -> Bool {
//        return lhs.id == rhs.id
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
}


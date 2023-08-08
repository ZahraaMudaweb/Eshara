//
//  Reminder.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//


import Foundation

struct Notify: Codable {
    let id: UUID
    let idStr: String?
    var amount: Double?
    var dueDate: Date?
    var notificationID: String?
    var paidDate: Date?
    var payee: String?
    var subject: String
    var description: String
    var date: String
    var time: String
    var remindDate: Date?
    
//    init(id: UUID = UUID()) {
//        self.id = id
//        self.idStr = "not-\(id)"
//
//    }
    
    init(id: UUID = UUID(), idStr: String?, amount: Double? = nil, dueDate: Date? = nil, notificationID: String? = nil, paidDate: Date? = nil, payee: String? = nil, subject: String = "", description: String = "", date: String = "", time : String = "", remindDate: Date? = nil) {
        self.id = id
        self.idStr = "not-\(id)"
        self.amount = amount
        self.dueDate = dueDate
        self.notificationID = notificationID
        self.paidDate = paidDate
        self.payee = payee
        self.subject = subject
        self.description = description
        self.date = date
        self.time = time
        self.remindDate = remindDate
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


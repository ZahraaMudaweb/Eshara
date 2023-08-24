//
//  PremiumPackage.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import Foundation

class PremiumPackage{
    
    var id: Int
    var name: String
    var price : String
    var period : String
    var issueDate : String
    var expiryDatre : String

    
    
    init(id: Int, name: String, price: String, period: String, issueDate: String, expiryDatre: String) {
        
        self.id = id
        self.name = name
        self.price = price
        self.period = period
        self.issueDate = issueDate
        self.expiryDatre = expiryDatre
        
    }
    
}

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
    var price : Int
    var period : String

    
    init(id:Int ,name: String, price: Int, period: String) {
        
        self.id = id
        self.name = name
        self.price = price
        self.period = period
        
    }
    
}

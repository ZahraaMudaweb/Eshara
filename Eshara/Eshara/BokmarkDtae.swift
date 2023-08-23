//
//  BokmarkDtae.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import Foundation
import UIKit

struct BookMarkDate
{
    var date: UIDatePicker
    
    
    init(date: UIDatePicker)
    {
        self.date = date
    }   
    
    func dictionaryRepresentation(datePickerrrr: UIDatePicker) -> [String: Any]
    {
        
//        let dateFormatted = DateFormatter()
//
//        dateFormatted.string(from: datePickerrrr.date)
        var dict: [String: Any] = [:]
        dict["date"] = "\(datePickerrrr.date)"
        return dict
    }
}

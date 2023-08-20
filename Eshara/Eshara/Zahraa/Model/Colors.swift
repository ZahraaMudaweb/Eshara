//
//  Colors.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 03/08/2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        let hexValue = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgbValue: UInt64 = 0
        
        guard Scanner(string: hexValue).scanHexInt64(&rgbValue) else {
            return nil
        }
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
let yellow = UIColor(hex: "##F8D90F")
let green = UIColor(hex: "##D3DD18")
let orange = UIColor(hex: "FE7A15")
let blue = UIColor(hex: "0191B4")
let lightBlue = UIColor(hex: "35BBCA")
let red = UIColor(hex: "ED1B24")

let colors = [yellow, green, orange, blue, lightBlue, red]

// coded by ChatGPT

//
//  Theme.swift
//  Eshara
//
//  Created by A M on 8/5/23.
//

import Foundation
import UIKit

enum TecherColors: String
{
    
    case yellow
    case lightblue
    case green
    case orenge
    
  var techerColor: UIColor
    {
        switch self
        {
        case .orenge:
            return UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        case .yellow:
            return UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha: 1)
        case .lightblue:
            return UIColor(red: (1/255.0), green: (145/255.0), blue: (180/255.0), alpha: 1)
        case .green:
            return UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha: 1)
        }
        
    }
}

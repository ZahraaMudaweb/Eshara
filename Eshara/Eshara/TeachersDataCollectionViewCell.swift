//
//  TeachersDataCollectionViewCell.swift
//  Eshara
//
//  Created by A M on 8/4/23.
//

import UIKit



class TeachersDataCollectionViewCell: UICollectionViewCell {
  
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var RateLabel: UILabel!
    @IBOutlet var LocationLabel: UILabel!
    @IBOutlet var PriceLabel: UILabel!
    
    
    func name( teacherName: String,  teacherRate: Double, teacherLocation: String, teacherPrice: Double)
    {
        LocationLabel.text = teacherLocation
        PriceLabel.text = "\(teacherPrice)"
        RateLabel.text = "\(teacherRate)"
        nameLabel.text = teacherName
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
  
    
    
    
    
    
}

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
    
    
    func name( teacherName: String,  teacherRate: String, teacherLocation: String, teacherPrice: String)
    {
        LocationLabel.text = "الموقع:\(teacherLocation)"
        PriceLabel.text = " السعر: \(teacherPrice) BHD"
        RateLabel.text = "التقييم:\(teacherRate)"
        nameLabel.text = "ألاسم:\(teacherName)"
        
        nameLabel.textAlignment = .right
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
       
        
    }
  
 
    
    
}

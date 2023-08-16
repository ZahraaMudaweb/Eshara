//
//  ReviewsCollectionViewCell.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell
{

    @IBOutlet var studentRate: UILabel!
    @IBOutlet var StudentName: UILabel!
    @IBOutlet var StudentComment: UILabel!
    
    var testing = ""
  
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
}

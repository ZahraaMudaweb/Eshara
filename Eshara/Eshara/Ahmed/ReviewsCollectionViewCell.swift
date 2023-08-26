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
    
    
  
    
    func update(with Comment: AddStudentrevie)
    {
        studentRate.text = Comment.studentRate
        StudentName.text = Comment.studentname
        StudentComment.text = Comment.StudentCommrnt
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
}

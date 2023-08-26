//
//  ReviewsCollectionViewCell.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ReviewsCollectionViewCell: UICollectionViewCell
{

    @IBOutlet var studentRate: UILabel!
    @IBOutlet var StudentName: UILabel!
    @IBOutlet var StudentComment: UILabel!
    
    
 
    
    
    func update(with Comment: AddStudentrevie)
    {
        
        studentRate.text = "التقييم:\(Comment.studentRate)"
        StudentName.text = "ألاسم:\(Comment.studentname)"
        StudentComment.text = "ألملاحظة:\(Comment.StudentCommrnt)"
     
        
    }
    
    
//    func userimge()
//    {
//        let storageRef = Storage.storage().reference()
//        let imageRef = storageRef.child("images/09UsxMDtCbQM9JdCjEtPtkcJN8j2.png")
//
//        imageRef.getData(maxSize: 5 * 1024 * 1024)
//        {
//            data, error in
//            if let error = error
//            {
//                print("Error downloading image: \(error)")
//            } else {
//                let image = UIImage(data: data!)
//                self.userimage.image = image
//            }
//        }
//      
//
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
}

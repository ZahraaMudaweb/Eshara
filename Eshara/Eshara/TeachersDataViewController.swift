//
//  TeachersDataViewController.swift
//  Eshara
//
//  Created by A M on 8/6/23.
//

import UIKit



private let reuseIdentifier = "Cell"


class TeachersDataViewController: UIViewController, TeachersCollectionDelegate
{
    func didSelectTeacher(_ teacher: Teacherdata)
    {
        nameLabel.text = teacher.teacherName
        locationLabel.text = teacher.teacherLocation
        rateLabel.text = "\(teacher.teacherRate)"
        priceLabel.text = "\(teacher.teacherPrice)"
    }
    
   

    
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    
    @IBOutlet var priceLabel: UILabel!
    
   
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
   
    
    
}

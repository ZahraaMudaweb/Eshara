//
//  TeachersDataViewController.swift
//  Eshara
//
//  Created by A M on 8/6/23.
//

import UIKit






class TeachersDataViewController: UIViewController
{

    // commetS
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    
    @IBOutlet var nameLabel: UILabel!
    
    
    
    @IBOutlet var priceLabel: UILabel!
    
    
    
    
    
    
    
    var teacher : Teacherdata?
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        nameLabel.text = teacher?.teacherName
        
    }
    
}

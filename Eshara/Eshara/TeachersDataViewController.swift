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
    
    
    
    
    @IBOutlet var TeacherView: UIView!
    
    
    
    
    @IBOutlet var TeacherInforView: UIView!
    
    
    
    
    
    @IBOutlet var StudentButton: UIButton!
    
    
    
    
    @IBOutlet var BookButton: UIButton!
    
    
    
    @IBOutlet var ButtonsView: UIView!
    
    
    var teacher : Teacherdata?
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
        nameLabel.text = teacher?.teacherName
        
    TeacherViewLayOut()
       
        
        
    }
    
    func TeacherViewLayOut()
    {
        
        TeacherView.layer.cornerRadius = 10
        TeacherView.layer.masksToBounds = true
        TeacherView.backgroundColor = UIColor(red: (1/255.0), green: (145/255.0), blue: (180/255.0), alpha: 1)
        
        TeacherInforView.layer.cornerRadius = 10
        TeacherInforView.layer.masksToBounds = true
        TeacherInforView.backgroundColor = UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha:1)
        
        
        StudentButton.layer.cornerRadius = 10
        StudentButton.layer.masksToBounds = true
        StudentButton.backgroundColor = UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha:1)
        
        BookButton.layer.cornerRadius = 10
        BookButton.layer.masksToBounds = true
        BookButton.backgroundColor = UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        
        
        ButtonsView.backgroundColor = UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        
        view.backgroundColor = UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
    }
    // TeacherView.backgroundColor = UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha: 1)
}

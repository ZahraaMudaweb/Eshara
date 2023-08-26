//
//  TeachersDataViewController.swift
//  Eshara
//
//  Created by A M on 8/6/23.
//

import UIKit






class TeachersDataViewController: UIViewController
{


    @IBOutlet var main: UILabel!
    
    
    @IBOutlet var mainone: UILabel!
    
    
    
    @IBOutlet var maintwo: UILabel!
    
    
    @IBOutlet var mainthree: UILabel!
    
    
    @IBOutlet var mainfour: UILabel!
    
    
    
    @IBOutlet var UpView: UIView!
    
    
    
    @IBOutlet var DownView: UIView!
    
    @IBOutlet var LocationLabel: UILabel!
    
    @IBOutlet var RateLabel: UILabel!
    
    
    @IBOutlet var NameLabel: UILabel!
    
    @IBOutlet var PriceLabel: UILabel!
    

    
    @IBOutlet var ReviewsButton: UIButton!
    
    
    
    
    @IBOutlet var BookmarkButton: UIButton!
    
    
    
    
    
    var teacher : Teacherdata?
    
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        
       
        
    TeacherViewLayOut()
        NameLabel.text = "ألاسم:\(teacher?.teacherName ?? "")"
        LocationLabel.text = "لموقع:\(teacher?.teacherLocation ?? "")"
     
        if let rate = teacher?.teacherRate
        {
            RateLabel.text = String("التقييم:\(rate)")
        }
        if let price = teacher?.teacherPrice
        {
            PriceLabel.text = String("السعر:\(price)")
        }
    }
    
    func TeacherViewLayOut()
    {
        
        UpView.layer.cornerRadius = 10
        UpView.layer.masksToBounds = true
        UpView.backgroundColor = UIColor(red: (1/255.0), green: (145/255.0), blue: (180/255.0), alpha: 1)
        
        DownView.layer.cornerRadius = 10
        DownView.layer.masksToBounds = true
        DownView.backgroundColor = UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha:1)
        
        
        ReviewsButton.layer.cornerRadius = 10
        ReviewsButton.layer.masksToBounds = true
        ReviewsButton.backgroundColor = UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha:1)
        
        BookmarkButton.layer.cornerRadius = 10
        BookmarkButton.layer.masksToBounds = true
        BookmarkButton.backgroundColor = UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        
        
//        ButtonsView.backgroundColor = UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
//
        view.backgroundColor = UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        
        main.text = "البيانات"
        mainone.text = "خبرة ١٠ سنوات في التحدث بلغ الاشارة"
        maintwo.text = "معد دورات تعليمة للغة الاشارة"
        mainthree.text = "مترجم لغة الاشارة معتمدة"
        mainfour.text = "موظف في جمعية الصم و البكم - الشاخورة"
    }
    // TeacherView.backgroundColor = UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha: 1)
    
    
    @IBAction func ReviewsButtontap(_ sender: UIButton)
    {
       
    }
    
 
    
    @IBAction func BookMarkButtonTap(_ sender: UIButton)
    {
        //performSegue(withIdentifier: "Book", sender: sender)
    }
    
 
}

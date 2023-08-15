//
//  TeachersDataViewController.swift
//  Eshara
//
//  Created by A M on 8/6/23.
//

import UIKit






class TeachersDataViewController: UIViewController
{


    
    
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
    }
    // TeacherView.backgroundColor = UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha: 1)
    
    
    @IBAction func ReviewsButtontap(_ sender: UIButton)
    {
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "reviews", let destinationVC = segue.destination as? ReviewsCollectionViewController
        {
            // MARK: Send the datePicker Data to the ReviewsCollectionViewController to check if hte user is able to add a review
            // use destinationVC.<the datayou want to check> 
            
           
        }
        
    }
    
    @IBAction func BookMarkButtonTap(_ sender: UIButton)
    {
        //performSegue(withIdentifier: "Book", sender: sender)
    }
    
}

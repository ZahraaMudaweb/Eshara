//
//  ConformationforBookingViewController.swift
//  Eshara
//
//  Created by iOSdev on 14/08/2023.
//

import UIKit
//<<<<<<< HEAD
import FirebaseDatabase
import FirebaseAuth


//=======
//>>>>>>> Ahmed

class ConformationforBookingViewController: UIViewController
{
    
    //<<<<<<< HEAD
    
    
    
    //=======
    
    //>>>>>>> Ahmed
    
    var sending = "Hellowworld"
    
    @IBOutlet var ConfoView: UIView!
    
    @IBOutlet var SucffleBookkMarket: UILabel!
    
    
    
    
    @IBOutlet var timeLabel: UILabel!
    
    var timeString = ""
    
    @IBOutlet var dayLabel: UILabel!
    
    var dayString = ""
    
    @IBOutlet var teacherNameLabel: UILabel!
    
    var TeacherString = ""
    
    @IBOutlet var DoneBateen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        timeLabel.text = timeString
        dayLabel.text = dayString
        
        Style()
        
    }
    
    
    
    func Style()
    {
        ConfoView.layer.cornerRadius = 10
        ConfoView.layer.masksToBounds = true
        ConfoView.backgroundColor = UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        
        DoneBateen.layer.cornerRadius = 10
        DoneBateen.layer.masksToBounds = true
        DoneBateen.backgroundColor = UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        view.backgroundColor =  UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        
    }
    
    
    
    @IBAction func DontButtontap(_ sender: Any)
    {
        
        //<<<<<<< HEAD
        
        
        // navigationController?.pushViewController(dec, animated: true)
        //  delegate?.sendData(data: "Hello World")
        //=======
        //>>>>>>> Ahmed
    }
    
    
    
    
    @IBSegueAction func sendingcon(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ReviewsCollectionViewController?
    {
        if segueIdentifier == "revcon"
        {
            print("send")
        }
        else
        {
            print("Error")
        }
        
        return ReviewsCollectionViewController(coder: coder)
    }
    
}

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



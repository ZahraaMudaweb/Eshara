//
//  ConformationforBookingViewController.swift
//  Eshara
//
//  Created by iOSdev on 14/08/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth



class ConformationforBookingViewController: UIViewController
{
    

    
   
    
    
  
    
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
        
        data()
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
        
    }
    
    
   
    @IBAction func DontButtontap(_ sender: Any)
    {
        
        guard let dec = storyboard?.instantiateViewController(withIdentifier: "revist") as? ReviewsCollectionViewController else {return}
        
        var sending = "Hello World"
        
        dec.dataRev = sending
        
       // navigationController?.pushViewController(dec, animated: true)
      //  delegate?.sendData(data: "Hello World")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
      
        
        if segue.identifier == "ConfToReview",
           let dec = segue.destination as? ReviewsCollectionViewController
        {
            let send = "Hellow World"
            dec.dataRev = send
            
        }
        else
        {
           // print("error")
        }
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
    
    
 func data()
    {
        let ref = Database.database().reference()
        
        let dateData: [String: Any] = ["name": "Ahmed", "age": 25, "email":"test@example.com"]
        
       // ref.child("user").child("testing").setValue(dateData)
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

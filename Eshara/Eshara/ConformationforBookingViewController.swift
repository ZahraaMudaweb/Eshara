//
//  ConformationforBookingViewController.swift
//  Eshara
//
//  Created by iOSdev on 14/08/2023.
//

import UIKit

class ConformationforBookingViewController: UIViewController
{
    
    
    @IBOutlet var ConfoView: UIView!
    
    @IBOutlet var SucffleBookkMarket: UILabel!
    
   
    
    
    @IBOutlet var timeLabel: UILabel!
    
    var timeString = ""
    
    @IBOutlet var dayLabel: UILabel!
    
    var dayString = ""
    
    @IBOutlet var teacherNameLabel: UILabel!
    
    var TeacherString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        timeLabel.text = timeString
        dayLabel.text = dayString
        
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

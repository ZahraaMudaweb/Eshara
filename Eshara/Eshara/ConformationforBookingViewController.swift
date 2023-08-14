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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Style()
    }
    

    
    
    
    
    func Style()
    {
        ConfoView.layer.cornerRadius = 10
        ConfoView.layer.masksToBounds = true
        ConfoView.backgroundColor =  UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1)
        
        SucffleBookkMarket.text = "تم التثبيت بنجاح"
        let font = UIFont(name: "FFHekaya-Light", size: 17)
        SucffleBookkMarket.font = font
        
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

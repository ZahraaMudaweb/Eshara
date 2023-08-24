//
//  PremiumPayViewController.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import UIKit

class PremiumPayViewController: UIViewController {

    
    
    
    var price: String = ""
    var Period: String = ""
    
    
    @IBOutlet var packegPrice: UILabel!
    
    
    @IBOutlet var periodPakeh: UILabel!
    var packeag: PremiumPackage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(packeag)
        
        if let packeag = packeag {
            
         packegPrice.text = packeag.price
         periodPakeh.text = packeag.period
            
        }
      
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func purchasePackage(_ sender: Any) {
        
        
        
        
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

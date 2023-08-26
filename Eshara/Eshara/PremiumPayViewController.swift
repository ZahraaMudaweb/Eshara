//
//  PremiumPayViewController.swift
//  Eshara
//
//  Created by iOSdev on 23/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        
        performSegue(withIdentifier: "updateHearts", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "updateHearts"
        {
            if let destions  = segue.destination as? profileViewController
            {

                updateHearts()

            }
        }
        
    }
    
    
    func updateHearts() {
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        // decrease user hearts
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for child in result {
                if child.key == "hearts" {
                    guard let value = child.value as? Int else {return}
                    
                    let newValue = value + 999999999 // to make it unlimited
                    
                    ref.child("user").child(uid!).updateChildValues(["hearts" : (newValue)])
                    
                }
            }
        })
    
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

//
//  profileViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
//private let reuseIdentifier = "Cell"
class profileViewController: UIViewController {
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passTextfield: UITextField!
    @IBOutlet var dobTextField: UITextField!
    @IBOutlet var userNameTextfield: UITextField!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        populateData()
        super.viewDidLoad()
        
    }
  
    @IBAction func signout(_ sender: UIButton) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "user_uid_key")
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error Signing out")
        }
    }
    
    func populateData(){
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        guard uid != nil else {
            print("Error fetching User ID")
            return
        }
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            
            self.emailTextField.text = value?["Email"] as? String
            self.userNameTextfield.text = value?["Name"] as? String
            self.dobTextField.text = value?["dob"] as? String
        })
    }
  

}

//
//  LoginViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
   
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else{
            let alert = UIAlertController(title: "Missing field data", message: "Please fill in the required field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "Invalid Credentials", message: "Invalid Credentials, please try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
                
                return
            }
            UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
            self.performSegue(withIdentifier: "profile", sender: sender)
        })
       
       
    }
    

}

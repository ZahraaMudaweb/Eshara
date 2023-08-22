//
//  LoginViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var orLabel: UILabel!
    
    @IBOutlet var guestButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var forgetPassButton: UIButton!
    @IBOutlet var firstTitleLabel: UILabel!
    @IBOutlet var haveAccountLabel: UILabel!
    
    @IBOutlet var secondTitleLabel: UILabel!

    @IBOutlet var usernameLabel: UILabel!
   
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    
     
    override func viewDidAppear(_ animated: Bool) {
        font_style()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboradNotification()
        
    }
    
    //change font style
    func font_style(){
        firstTitleLabel.font =  UIFont(name: "FF Hekaya", size: 40)
        secondTitleLabel.font =  UIFont(name: "FF Hekaya", size: 30)
        haveAccountLabel.font =  UIFont(name: "FF Hekaya", size: 20)
        orLabel.font =  UIFont(name: "FF Hekaya", size: 20)
        forgetPassButton.titleLabel?.font =  UIFont(name: "FF Hekaya", size: 20)
        signupButton.titleLabel?.font =  UIFont(name: "FF Hekaya", size: 20)
        guestButton.titleLabel?.font =  UIFont(name: "FF Hekaya", size: 20)
        loginButton.titleLabel?.font =  UIFont(name: "FF Hekaya", size: 20)
        emailTextfield.font =  UIFont(name: "FF Hekaya", size: 20)
        passwordTextfield.font =  UIFont(name: "FF Hekaya", size: 20)
    }
    
    
    //user login with email
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else{
            let alert = UIAlertController(title: "بيانات غي مكتملة", message: "الرجاد ملئ البيانات", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))

            self.present(alert, animated: true)
            
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            guard error == nil else {
                let alert = UIAlertController(title: "بيانات الاعتماد غير صالحة", message: "بيانات الاعتماد غير صالحة، يرجى المحاولة مرة أخرى", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))

                self.present(alert, animated: true)
                
                return
            }
            UserDefaults.standard.set(Auth.auth().currentUser!.uid, forKey: "user_uid_key")
//            self.performSegue(withIdentifier: "profile", sender: sender)
            
        })
      
    }
    
   
    
    
    
    
    
    
    
    //keyboard
    func registerForKeyboradNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil)
        
    }
    @objc func keyboardWasShown (_ notification: NSNotification){
        guard let info = notification.userInfo,
              let keyboiardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboiardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillBeHidden(_ notification: NSNotification){
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
    }
}

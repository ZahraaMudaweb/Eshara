//
//  ForgetPassViewController.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 07/08/2023.
//

import UIKit
import FirebaseAuth
class ForgetPassViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      registerForKeyboradNotification()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        font_style()
    }
    
    //change font style
    func font_style(){
        emailLabel.font = UIFont(name: "FF Hekaya", size: 20)
        emailTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        sendButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
    }
    
    //send email to the user to reset password
    @IBAction func forgetPass(_ sender: Any) {
        guard let email = emailTextfield.text, !email.isEmpty   else {
            let alert = UIAlertController(title: "بيانات غي مكتملة", message: "الرجاد ملئ البيانات", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                let alert = UIAlertController(title: "خطأ", message: "خطأ في إرسال الرسالة ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            let alert = UIAlertController(title: "نجاح", message: "تم إرسال الرسالة بنجاح ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
        }
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

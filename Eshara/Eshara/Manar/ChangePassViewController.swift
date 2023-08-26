//
//  ChangePassViewController.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 08/08/2023.
//

import UIKit
import FirebaseAuth
class ChangePassViewController: UIViewController {

    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var changePassLabel: UIButton!
    @IBOutlet var confirmPassLabel: UILabel!
    @IBOutlet var newPassLabel: UILabel!
    @IBOutlet var confirmPassTextfield: UITextField!
    @IBOutlet var newPassTextfield: UITextField!
    
   // @IBOutlet var oldPassTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
registerForKeyboradNotification()
       
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        font_style()
    }
    
    //change font style
    func font_style(){
        newPassLabel.font = UIFont(name: "FF Hekaya", size: 20)
        confirmPassLabel.font = UIFont(name: "FF Hekaya", size: 20)
        newPassTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        confirmPassTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        changePassLabel.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
    }

    //change user password
    @IBAction func changePass(_ sender: Any) {
        
        
        guard  let newpass = newPassTextfield.text, let confirmPass = confirmPassTextfield.text,  !newpass.isEmpty && !confirmPass.isEmpty   else {
            let alert = UIAlertController(title: "بيانات غي مكتملة", message: "الرجاد ملئ البيانات", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        guard newpass == confirmPass else {
            let alert = UIAlertController(title: "كلمات المرور غير متطابقة", message: "الرجاء إدخال كلمات مرور متطابقة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        Auth.auth().currentUser?.updatePassword(to: newpass) { error in
            guard error == nil else {
                let alert = UIAlertController(title: "خطأ", message: "خطأ في تغيير كلمة المرور ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
                self.present(alert, animated: true)
                return
            }
            let alert = UIAlertController(title: "نجاح", message: "تم تغيير كلمة المرور بنجاح ", preferredStyle: .alert)
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

//
//  SignupViewController.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 03/08/2023.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase
import FirebaseStorage

class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var dobDate: UIDatePicker!
    @IBOutlet var scrollView: UIScrollView!
    private let storage = Storage.storage().reference()
    
    
    @IBOutlet var firstTitleLabel: UILabel!
    
    @IBOutlet var secondTitleLabel: UILabel!
    
    @IBOutlet var changeImagebutton: UIButton!
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var teacherPriceTextfield: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var userType: UISegmentedControl!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var DOBTextfield: UITextField!
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    
    override func viewDidLoad() {
        registerForKeyboradNotification()
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        super.viewDidLoad()
         }
    override func viewWillAppear(_ animated: Bool) {
        font_style()
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
    }
    
    //change font style
    func font_style(){
        firstTitleLabel.font = UIFont(name: "FF Hekaya", size: 40)
        secondTitleLabel.font = UIFont(name: "FF Hekaya", size: 30)
        
        emailTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        usernameTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        DOBTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        passwordTextField.font = UIFont(name: "FF Hekaya", size: 20)
        confirmPassTextField.font = UIFont(name: "FF Hekaya", size: 20)
        locationTextField.font = UIFont(name: "FF Hekaya", size: 20)
        teacherPriceTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        signupButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        changeImagebutton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        
        
    }

  //create new user
    @IBAction func signup(_ sender: UIButton) {//let dob = DOBTextfield.text,&& !dob.isEmpty 
        guard let dob = DOBTextfield.text,let username = usernameTextfield.text, let email = emailTextfield.text, let password = passwordTextField.text, let confirmPass = confirmPassTextField.text,  let usertype = userType.selectedSegmentIndex as Int?, let price = teacherPriceTextfield.text, let location = locationTextField.text, !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPass.isEmpty && !dob.isEmpty    else {
            let alert = UIAlertController(title: "بيانات غي مكتملة", message: "الرجاد ملئ البيانات", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        guard password == confirmPass else{
            let alert = UIAlertController(title: "كلمات المرور غير متطابقة", message: "الرجاء إدخال كلمات مرور متطابقة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
       FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
           guard error == nil else {
               let alert = UIAlertController(title: "خطأ", message: "خطأ في إنشاء الحساب", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))

               self.present(alert, animated: true)
               return
           }
           
           let ref = Database.database().reference()
           let uid = Auth.auth().currentUser?.uid
           ref.child("user").child(uid!).setValue(["Email" : email, "Name" : username, /*"dob": self.dobDate.date, */"userType" : usertype, "location":location, "price": price
                                                   /*,"setting":[
            ["switche": false, "name": "الإشعارات"],
            ["switche": false, "name": "الأصوات"],
                    ["switche": false, "name": "الإعلانات"],
                    ["switche": false, "name": "الوصول للموقع"]
                    
           ]*/])

           guard let image = self.imageView.image else {
               return
           }
           guard let imageData = image.pngData() else {
               return
           }
           self.storage.child("images/\(uid!).png").putData(imageData, metadata: nil, completion: { _, error in guard error == nil else{
               return
           }
               self.storage.child("images/\(uid!).png").downloadURL(completion: { url, error in
                   guard let url = url, error == nil else {
                       return
                   }
                   let urlString = url.absoluteString
                   print("Download URL: \(urlString)")
                   UserDefaults.standard.set(urlString, forKey: "url")
               })
           })
           let alert = UIAlertController(title: "نجاح", message: "تم انشاء الحساب بنجاح", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in

               self.navigationController?.popToRootViewController(animated: true)
           }))
           self.present(alert, animated: true)
           self.navigationController?.popToRootViewController(animated: true)
                               
            })
        
    }
    
    
 //upload user image
    @IBAction func uploadImage(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        imageView.image = image
    }
    
    //chane field depending on user type
    @IBAction func changeUserType(_ sender: Any) {
        if userType.selectedSegmentIndex == 1 { // user type = student
            teacherPriceTextfield.isHidden = true
            locationTextField.isHidden = true
            teacherPriceTextfield.text = ""
            locationTextField.text = ""
        }else {
            teacherPriceTextfield.isHidden = false
            locationTextField.isHidden = false

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

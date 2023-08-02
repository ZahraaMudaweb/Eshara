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
    private let storage = Storage.storage().reference()
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var userType: UISegmentedControl!
    @IBOutlet var confirmPassTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var DOBTextfield: UITextField!
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var emailTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let image = UIImageView(frame: CGRectMake(0, 0, 100, 100))
      
       // self.imageView.layer.borderWidth = 1.0
        //self.imageView.layer.masksToBounds = true
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        
        
       // self.imageView.layer.cornerRadius = CGRectGetWidth(self.imageView.frame)/1.5
        
        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func signup(_ sender: UIButton) {
        guard let username = usernameTextfield.text, let email = emailTextfield.text, let password = passwordTextField.text, let confirmPass = confirmPassTextField.text, let dob = DOBTextfield.text, let usertype = userType.selectedSegmentIndex as Int?, !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPass.isEmpty  && !dob.isEmpty && password == confirmPass   else {
            let alert = UIAlertController(title: "Missing field data", message: "please fill in all the field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: true)
            return
        }
       FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result, error in
           guard error == nil else {
               let alert = UIAlertController(title: "Error", message: "Signup failed", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .cancel))
               self.present(alert, animated: true)
               return
           }
           
           let ref = Database.database().reference()
           let uid = Auth.auth().currentUser?.uid
           ref.child("user").child(uid!).setValue(["Email" : email, "Name" : username, "dob": dob, "userType" : usertype])
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
                   UserDefaults.standard.set(usertype, forKey: "url")
               })
           })
           let alert = UIAlertController(title: "Success", message: "Account successfuly created", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
               self.navigationController?.popToRootViewController(animated: true)
           }))
           self.present(alert, animated: true)
           self.navigationController?.popToRootViewController(animated: true)
                               
            })
        
    }
    
    
 
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
    
}

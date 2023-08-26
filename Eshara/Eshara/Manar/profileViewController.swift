//
//  profileViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
//private let reuseIdentifier = "Cell"
class profileViewController: UIViewController,
                             UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    
    @IBOutlet var redirectLogin: UIStackView!
    @IBOutlet var profileStackView: UIStackView!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var dobLabel: UILabel!
    
    @IBOutlet var usernameLabel: UILabel!
    
    
    @IBOutlet var changeImageButton: UIButton!
    
    @IBOutlet var signOutButton: UIButton!
    
    @IBOutlet var deleteAccountButton: UIButton!
    
    @IBOutlet var saveChangeButton: UIButton!
    
    @IBOutlet var changePassButton: UIButton!
    
    private let storage = Storage.storage().reference()
    
    @IBOutlet var priceTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passTextfield: UITextField!
    @IBOutlet var dobTextField: UITextField!
    @IBOutlet var userNameTextfield: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet weak var premiumLbl: UILabel!
    
    @IBOutlet weak var btnBePremium: UIButton!
    
    var hearts: Int = 10
    
    override func viewDidLoad() {
       
        registerForKeyboradNotification()
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        super.viewDidLoad()
       
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
        
        //load user image
        let uid = Auth.auth().currentUser?.uid
        if uid != nil {
        let path = "images/\(uid!).png"
        let storage = Storage.storage().reference(withPath: path)
        storage.getData(maxSize: (104857666), completion: {(data, error) in if let error = error{
            print(error)
        }else {
            if let image = data {
                let myImage:UIImage! = UIImage(data: image)
                self.imageView.image = myImage
            }
        }
        })
            
            populateData()
            font_style()
             //change image radius
             self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
             self.imageView.clipsToBounds = true
            redirectLogin.isHidden = true
            profileStackView.isHidden = false
    }
        else{
            redirectLogin.isHidden = false
            profileStackView.isHidden = true
        }
        
        getHearts()
        if self.hearts > 10
        {
            self.btnBePremium.isHidden = true
            self.premiumLbl.isHidden = false
        }
        else{
            self.btnBePremium.isHidden = false
            self.premiumLbl.isHidden = true
        }
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        let mainNavigation = MainNavigationController(rootViewController: viewController)
        
        mainNavigation.modalPresentationStyle = .popover
        self.present(mainNavigation, animated: true)
        
        
    }
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignupViewController
        let mainNavigation = MainNavigationController(rootViewController: viewController)
        
        mainNavigation.modalPresentationStyle = .popover
        self.present(mainNavigation, animated: true)
    }
    
    //change font style
    func font_style(){
        priceLabel.font = UIFont(name: "FF Hekaya", size: 20)
        emailLabel.font = UIFont(name: "FF Hekaya", size: 20)
        usernameLabel.font = UIFont(name: "FF Hekaya", size: 20)
        locationLabel.font = UIFont(name: "FF Hekaya", size: 20)
        dobLabel.font = UIFont(name: "FF Hekaya", size: 20)
        titleLabel.font = UIFont(name: "FF Hekaya", size: 40)
        
        emailTextField.font = UIFont(name: "FF Hekaya", size: 20)
        userNameTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        dobTextField.font = UIFont(name: "FF Hekaya", size: 20)
        priceTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        locationTextfield.font = UIFont(name: "FF Hekaya", size: 20)
        
        signOutButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        deleteAccountButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        changePassButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        changeImageButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
        saveChangeButton.titleLabel?.font = UIFont(name: "FF Hekaya", size: 20)
    }
    
    
    
    
    func populateData(){
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        guard uid != nil else {
            print("Error fetching User ID")
            return
        }
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: { [self](snapshot) in
            let value = snapshot.value as? NSDictionary
            
            self.emailTextField.text = value?["Email"] as? String
            self.userNameTextfield.text = value?["Name"] as? String
            self.dobTextField.text = value?["dob"] as? String
            self.locationTextfield.text = value?["location"] as? String
            self.priceTextfield.text = value?["price"] as? String
             
            if value?["userType"] as? Int == 1 {
                self.locationTextfield.isHidden = true
                priceTextfield.isHidden = true
                priceLabel.isHidden = true
                locationLabel.isHidden = true
                
            }else{
                locationTextfield.isHidden = false
                priceTextfield.isHidden = false
                priceLabel.isHidden = false
                locationLabel.isHidden = false
            }
        })
      
    }
    
    @IBAction func signout(_ sender : Any){
        do{
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "user_uid_key")
            self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error Signing out")
        }
    }
    
    
  //change profile image
    @IBAction func changeImage(_ sender: Any) {
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
    
    //update user profile data
   @IBAction func updateProfile(_ sender: UIButton) {
        
       guard let username = userNameTextfield.text, let email = emailTextField.text, let dob = dobTextField.text, let price = priceTextfield.text, let location = locationTextfield.text, !username.isEmpty && !email.isEmpty  &&  !dob.isEmpty else {
            let alert = UIAlertController(title: "بيانات غي مكتملة", message: "الرجاد ملئ البيانات", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "حسنا", style: .cancel))
            self.present(alert, animated: true)
            return
        }
        
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        ref.child("user").child(uid!).setValue(["Email" : email, "Name" : username, "dob": dob, "location":location, "price": price])
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
        let alert = UIAlertController(title: "نجاح", message: "تم تغيير المعلومات بنجاح", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in
           // self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
        //self.navigationController?.popToRootViewController(animated: true)
                            
         
     
        
    }
    
    
    // delete account
  @IBAction func deleteAccount(_ sender: UIButton) {
      
      //delete user from realtime DB
      let ref = Database.database().reference()
      let uid = Auth.auth().currentUser?.uid
      ref.child("user").child(uid!).removeValue { error, _ in
          if let error = error {
              let alert = UIAlertController(title: "حطأ", message: "خطأ", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in
                 // self.navigationController?.popToRootViewController(animated: true)
              }))
              self.present(alert, animated: true)
              print(error) }}
      
      //delete user profile images from DB
      self.storage.child("images/\(uid!).png").delete{ error in
          if let error = error {
              let alert = UIAlertController(title: "خطأ", message: "خطأ", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in
                 // self.navigationController?.popToRootViewController(animated: true)
              }))
              self.present(alert, animated: true)
              print(error) }
          }
        

      //delete user authontication
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              let alert = UIAlertController(title: "خطأ", message: "خطأ", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in
                 // self.navigationController?.popToRootViewController(animated: true)
              }))
              self.present(alert, animated: true)
              
          } else {
              let alert = UIAlertController(title: "نجاح", message: "تم حذف الحساب بنجاح ", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "حسنا", style: .cancel, handler: { _ in
                  self.navigationController?.popToRootViewController(animated: true)
              }))
              
              //user signout
              do{
                  try FirebaseAuth.Auth.auth().signOut()
                  UserDefaults.standard.removeObject(forKey: "user_uid_key")
              }catch{
                  print("Error Signing out")
              }
              self.present(alert, animated: true)
              
              
          }
        }
     }
    
    
    //app setting
    @IBAction func phonesetting(_ sender: Any) {

         let url = URL(string:UIApplication.openSettingsURLString)
                if UIApplication.shared.canOpenURL(url!){
                    // can open succeeded.. opening the url
                    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
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
    
    
    func getHearts() {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        // decrease user hearts
        ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for child in result {
                if child.key == "hearts" {
                    guard let value = child.value as? Int else {return}
                    let newValue = value
                    self.hearts = newValue
                }
            }
        })
    
    }
    
    @IBAction func unwindToProfileView(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "updateHearts",
              let sourceViewController = segue.source
                as? PremiumPayViewController else { return }
       
        getHearts()
    }
}

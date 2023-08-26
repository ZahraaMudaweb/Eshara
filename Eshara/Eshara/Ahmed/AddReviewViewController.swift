//
//  AddReviewViewController.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AddReviewViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickervalue.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        CommenttextField.resignFirstResponder()
        textfieldpicker.resignFirstResponder()
        return true
    }
    

    @IBOutlet var userimage: UIImageView!
    
    
    
    
    @IBOutlet var addratelabel: UILabel!
    
    
    @IBOutlet var addcomentlabel: UILabel!
    
    
    var boomar: BookMarkDate?
    var AddstudentRevie: AddStudentrevie?
    var ReviewArray: [String] = []
    
    @IBOutlet var StudentCommentView: UIView!
    
    @IBOutlet var CommenttextField: UITextField!
    
    var locolusername: String?
   
    @IBOutlet var StudentButtonComment: UIButton!
    
    @IBOutlet var textfieldpicker: UITextField!
    @IBOutlet var rateLabel: UILabel!
    
    let picker = UIPickerView()
    let pickervalue = Array(1...10)
    
    
    
     init?(coder: NSCoder, AddstudentRevie: AddStudentrevie?)
    {
        self.AddstudentRevie = AddstudentRevie
        super.init(coder: coder)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        // Do any additional setup after loading the view.
      
        CommenttextField.addTarget(self, action: #selector(canAddComment(_:)), for: .editingChanged)
        canAddComment(CommenttextField)
        
        setupPicker()
        style()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hidethekeyboead(_:)))
          view.addGestureRecognizer(tapGesture)
        CommenttextField.delegate = self
        
         fetchUsername()
  
        
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
 
    
    
    @objc func canAddComment(_ textField: UITextField)
    {
       
        let comment = CommenttextField.text ?? ""
        StudentButtonComment.isEnabled = !comment.isEmpty
    }
    
    
    @IBAction func textField(_ sender: UITextField)
    {
        canAddComment(CommenttextField)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveButton" else {return}
        
        let comment = self.CommenttextField.text ?? ""
        let rate = self.textfieldpicker.text ?? ""
        let newReviw = AddStudentrevie(studentRate: rate, StudentCommrnt: comment, studentname: locolusername ?? "")
        AddstudentRevie = newReviw
    }
    
    func sendRevietofire()
    {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        
        var bookmard = boomar ?? BookMarkDate(date: "None", Rate: "None")
        
        guard let date = CommenttextField.text,
              let Rate = textfieldpicker.text else {return}
        bookmard.date = date
        bookmard.Rate = Rate
     // ["Reviews": "\(CommenttextField.text ?? "")"]

        ref.child("user").child(uid!).child("Reviews").setValue(bookmard.dictionaryReviews())
        { [self]
            (error, _)
            in if let error = error
            {
                print(error)
            }
            else
            {
                print("Done")
                
                ReviewArray.append(date)
                ReviewArray.append(Rate)
                print(ReviewArray)
            }
        }
       
        
    }
    
    
    @IBAction func CommentTextButton(_ sender: UIButton)
    {
        sendRevietofire()   
    }
    
    
    
    func setupPicker()
    {
        textfieldpicker.inputView = picker
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
         textfieldpicker.text = String(pickervalue[row])
     }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickervalue[row])
    }
    @objc func hidethekeyboead(_ gestureRecoginizer: UIGestureRecognizer)
    {
        textfieldpicker.resignFirstResponder()
        CommenttextField.resignFirstResponder()
    }
    
    
    func style()
    {
        
        StudentCommentView.layer.cornerRadius = 10
        StudentCommentView.layer.masksToBounds = true
        StudentCommentView.backgroundColor =  UIColor(red: (1/255.0), green: (145/255.0), blue: (180/255.0), alpha: 1)
        
        StudentButtonComment.layer.cornerRadius = 10
        StudentButtonComment.layer.cornerRadius = 10
        StudentButtonComment.backgroundColor = UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha: 1)
       
       
        
        view.backgroundColor =  UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        addcomentlabel.text = "ضع تعليقا"
        addratelabel.text = "ضع تقييمك"
        
        
    }
    

    func fetchUsername() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let ref = Database.database().reference()

        ref.child("user").child(uid).child("Name").observe(.value) {  snapshot in
            guard let username = snapshot.value as? String else {
                print("Error: Failed to fetch username.")
                return
            }

            print("Username: \(username)")

            self.locolusername = username
            
         
                          let comment = self.CommenttextField.text ?? ""
                          let rate = self.textfieldpicker.text ?? ""
                          let newReviw = AddStudentrevie(studentRate: rate, StudentCommrnt: comment, studentname: username)
                            self.AddstudentRevie = newReviw

        }
    }
    
  
}

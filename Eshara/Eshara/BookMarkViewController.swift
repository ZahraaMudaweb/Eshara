//
//  BookMarkViewController.swift
//  Eshara
//
//  Created by A M on 8/13/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class BookMarkViewController: UIViewController {

   
    
    @IBOutlet var ConfButtin: UIButton!
    
    @IBOutlet var bookDatePicker: UIDatePicker!
    
  var testing = "HelloWord"
    
    @IBOutlet var datepickerlabel: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePickerSet(bookDatePicker)
      

        // Convert Date to String
       
        
        
    }
    

    
    
    
    
    func datePickerSet(_ datePicker: UIDatePicker)
    {
        datePicker.datePickerMode = .dateAndTime
        let calender = 	Calendar.current
        let currentDate = Date()
        let maxDate = calender.date(byAdding: .day, value: 5, to: currentDate)
        datePicker.minimumDate = maxDate
        datePicker.minimumDate = currentDate
        datePicker.locale = Locale.current
        datePicker.timeZone = TimeZone.current
        
        
        
        datePicker.layer.backgroundColor = .init(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        datePicker.layer.cornerRadius = 10
        datePicker.layer.masksToBounds = true
        
        
        datepickerlabel.text = bookDatePicker.date.formatted(date: .numeric, time: .omitted)
       
        Style()

    }
    
    
    func updateRemindUI()
    {
        datepickerlabel.text = bookDatePicker.date.formatted(date: .numeric, time: .shortened)
    }
    
    @IBAction func ConfButtonTap(_ sender: UIButton)
    {
        performSegue(withIdentifier: "conf", sender: sender)
    }
    
    
    
    @IBAction func DatePickerTapp(_ sender: UIDatePicker)
    {
        updateRemindUI()
 
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conf", let destinationVC = segue.destination as? ConformationforBookingViewController
        {
              let datetime = DateFormatter()
            
            datetime.dateFormat = "HH:mm a"
          datetime.locale = .current
          datetime.timeStyle = .short
                
            let dateday = DateFormatter()
            
            dateday.dateFormat = "dd"
            let datedaystring = dateday.string(from: bookDatePicker.date)
       
           
              let dateString = datetime.string(from: bookDatePicker.date)
            destinationVC.dayString = datedaystring
            destinationVC.timeString = dateString
            destinationVC.navigationItem.setHidesBackButton(true, animated: false)
            
            sendBookToFirebase(datePickerrr: bookDatePicker)
            
        }
       
    }
    
    
    
    
    func Style()
    {
        ConfButtin.backgroundColor = UIColor(red: (53/255.0), green: (187/255.0), blue: (202/255.0), alpha: 1)
        ConfButtin.layer.cornerRadius = 10
        ConfButtin.layer.masksToBounds = true
    //    ConfButtin.colo
    }
    
    
    func sendBookToFirebase(datePickerrr: UIDatePicker)
    {
        
       // let datePickerFormateed = DateFormatter()
        
       
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.string(from: datePickerrr.date)
                
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
          //  .child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("BookMark")
        
//        ref.child("user").child(uid!).observeSingleEvent(of: .value)
//        {
//            snapshot in
//            guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
//
//            for child in result
//            {
//                let key = child.key
//                let value = child.value as? NSDictionary
//            }
            
                        
            ref.child("user").child(uid!).child("Bookmark").setValue(["date": "\(datePickerrr.date.formatted())"])
            {
                (error, _ )
                in if let error = error
                {
                    print(error)
                }
                else
                {
                    print("Done")
                }
            }
 
//        }
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

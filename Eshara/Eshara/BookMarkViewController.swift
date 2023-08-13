//
//  BookMarkViewController.swift
//  Eshara
//
//  Created by A M on 8/13/23.
//

import UIKit

class BookMarkViewController: UIViewController {

    
    
    
    @IBOutlet var bookDatePicker: UIDatePicker!
    
    
    
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
        
        
    
        // Set the locale and time zone
        datePicker.locale = Locale.current
        datePicker.timeZone = TimeZone.current
        datePicker.date = currentDate
       


    }
    
    
    @IBAction func ConfButtonTap(_ sender: UIButton)
    {
        performSegue(withIdentifier: "conf", sender: sender)
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

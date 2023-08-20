//
//  AlertDetailTableViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit

import FirebaseAuth
import FirebaseDatabase


class AlertDetailTableViewController: UITableViewController, UITextFieldDelegate {
    private let datePickerHeight = CGFloat(216)
    private let dueDateCellIndexPath = IndexPath(row: 2, section: 0)
    private let remindDateCellIndexPath = IndexPath(row:0, section: 1)
    private let noteCellIndexPath = IndexPath(row:1, section: 0)
    
    @IBOutlet var payeeTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!
   
    @IBOutlet var remindStatusLabel: UILabel!
    @IBOutlet var remindSwitch: UISwitch!
    @IBOutlet var remindDatePicker: UIDatePicker!
    
    @IBOutlet var paidStatusLabel: UILabel!
    @IBOutlet var paidSwitch: UISwitch!
    @IBOutlet var paidDateLabel: UILabel!
    
    var isDueDatePickerShown: Bool = false {
        didSet {
            dueDatePicker.isHidden = !isDueDatePickerShown
        }
    }
    var isRemindDatePickerShown: Bool = false {
        didSet {
            remindDatePicker.isHidden = !isRemindDatePickerShown
        }
    }
    
    var alert: Notify?
    var paidDate: Date?
    
    
    init?(coder: NSCoder, alert: Notify?) {
        self.alert = alert
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        
        tableView.addGestureRecognizer(tapGestureRecognizer)
        
        //tableView(tableView: tableView, viewForHeaderInSection:0)
        
        //amountTextField.keyboardType = .decimalPad
        
//        paidDateLabel.text = ""
        
//        dueDatePicker.date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(86399)
        
        //updateDueDateUI()
        
        if let alert = alert {
            title = "تعديل التذكير"
            
//            payeeTextField.text = alert.payee
            payeeTextField.text = alert.subject
            
//            amountTextField.text = String(format: "%@", arguments: [(alert.amount ?? 0).formatted(.number.precision(.fractionLength(2)))])
            
            amountTextField.text = alert.description
            
//            if let dueDate = alert.dueDate {
//                dueDatePicker.date = dueDate
//            }
            
            //updateDueDateUI()
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            
            remindSwitch.isOn = alert.isReminder
            
            remindDatePicker.date = (alert.date != nil) ? dateFormatter.date(from: "\(alert.date) \(alert.time)")!  : Date()
            
            updateRemindUI()
            
//            paidSwitch.isOn = alert.isPaid
//            paidDate = alert.paidDate
//
//            updatePaymentUI()
            
//            navigationItem.leftBarButtonItem = nil
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "إلغاء", style: .plain, target: self, action: #selector(cancelButtonTapped))
            
        } else {
            title = "إضافة تذكير"
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "إلغاء", style: .plain, target: self, action: #selector(cancelButtonTapped))
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateDueDateUI() {
        dueDateLabel.text = dueDatePicker.date.formatted(date: .numeric, time: .omitted)
        remindDatePicker.maximumDate = dueDatePicker.date
    }
    
    func updateRemindUI() {
        if remindSwitch.isOn {
            remindStatusLabel.text = remindDatePicker.date.formatted(date: .numeric, time: .shortened)
        } else {
            remindStatusLabel.text = "لا"
        }
    }
    
    func updatePaymentUI() {
        if paidSwitch.isOn {
            paidStatusLabel.text = "Yes"
            paidDateLabel.text = Date().formatted(date: .abbreviated, time: .omitted)
        } else {
            paidStatusLabel.text = "No"
            paidDateLabel.text = ""
        }
    }
    
    @IBAction func remindSwitchChanged(_ sender: UISwitch) {

        if sender.isOn {
            //isDueDatePickerShown = false
            isRemindDatePickerShown = true
        } else {
            isRemindDatePickerShown = false
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        updateRemindUI()
    }
    
    @IBAction func paymentSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            paidDate = Date()
        } else {
            paidDate = nil
        }
        updatePaymentUI()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (dueDateCellIndexPath.section, dueDateCellIndexPath.row):
            updateDueDateUI()
            
            if isDueDatePickerShown {
                isDueDatePickerShown = false
            } else if isRemindDatePickerShown {
                isRemindDatePickerShown = false
                isDueDatePickerShown = true
            } else {
                isDueDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (remindDateCellIndexPath.section, remindDateCellIndexPath.row):
            if isRemindDatePickerShown {
                isRemindDatePickerShown = false
            } else if isDueDatePickerShown {
                isDueDatePickerShown = false
                isRemindDatePickerShown = true
            } else {
                isRemindDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (dueDateCellIndexPath.section, dueDateCellIndexPath.row + 1):
            if isDueDatePickerShown {
                return datePickerHeight
            } else {
                return 0
            }
        case (remindDateCellIndexPath.section, remindDateCellIndexPath.row + 1):
            if isRemindDatePickerShown {
                return datePickerHeight
            } else {
                return 0
            }
        case (noteCellIndexPath.section, noteCellIndexPath.row ):
                return 100
            
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        let headerView = UIView()
//        headerText.textColor = UIColor.lightGrayColor()
        headerText.adjustsFontSizeToFitWidth = true
        
        headerView.backgroundColor = UIColor.green
        
        switch section{
        case 0:
            headerText.textAlignment = .right
            headerText.text = "الملاحظات"
            headerText.font = UIFont(name: "FF Hekaya", size: 25)
        case 1:
            headerText.textAlignment = .right
            headerText.text = "تفاصيل التذكير"
            headerText.font = UIFont(name: "FF Hekaya", size: 25)
        default:
            headerText.textAlignment = .right
            //headerText.text = "Default Will Be Left"
            headerText.font = UIFont(name: "FF Hekaya", size: 25)
        }

        return headerText
    }
    
    func presentNeedAuthorizationAlert() {
        let alert = UIAlertController(title: "Authorization Needed", message: "We can't set reminders for you without notification permissions. Please go to the iOS Settings app and grant us notification permissions if you wish to make use of reminders.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dueDatePickerValueChanged(_ sender: UIDatePicker) {
        updateDueDateUI()
    }
    
    @IBAction func remindDatePickerValueChanged(_ sender: UIDatePicker) {
        updateRemindUI()
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return false
////        if textField == amountTextField {
////            let text = (textField.text ?? "") as NSString
////            let newText = text.replacingCharacters(in: range, with: string)
////            if let _ = Double(newText) {
////                return true
////            }
////            return newText.isEmpty
////        } else {
////            return true
////        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //var alrt = self.alert ?? LocalDatabase.shared.addAlert()
        
//        alrt.payee = payeeTextField.text
//        alrt.amount = Double(amountTextField.text ?? "0") ?? 0.00
//        alrt.dueDate = dueDatePicker.date
//        alrt.paidDate = paidDate
//
//        if remindSwitch.isOn {
//            alrt.scheduleReminder(on: remindDatePicker.date) { (updatedAlert) in
//                if updatedAlert.notificationID == nil {
//                    self.presentNeedAuthorizationAlert()
//                }
//
//                LocalDatabase.shared.updateAndSave(updatedAlert)
//            }
//        } else {
//            alrt.removeReminder()
//            LocalDatabase.shared.updateAndSave(alrt)
//        }
        
        guard segue.identifier == "saveUnwind" else { return }
        
    
        let subject = payeeTextField.text ?? ""
        let desc = amountTextField.text ?? ""
        
        let remindDateFormatter = DateFormatter()
        remindDateFormatter.dateFormat = "yyyy-MM-dd"

        let remindTimeFormatter = DateFormatter()
        remindTimeFormatter.dateFormat = "hh:mm a"
        
        let remindDate = remindDateFormatter.string(from: remindDatePicker.date) as? String ??  remindDateFormatter.string(from: Date())
        
        let remindTime = remindTimeFormatter.string(from: remindDatePicker.date) as? String ??  remindTimeFormatter.string(from: Date())

        let hasReminder =  remindSwitch.isOn ? 1 : 0
        
        self.alert = Notify(idStr: self.alert?.idStr, subject: subject, description: desc, date: remindDate, time: remindTime, isReminder:  remindSwitch.isOn )
        
 
 
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    


}

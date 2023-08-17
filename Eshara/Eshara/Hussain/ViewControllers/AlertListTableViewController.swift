//
//  AlertListTableViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit

import CoreData

import FirebaseAuth
import FirebaseDatabase



private class SwipeableDataSource: UITableViewDiffableDataSource<Int, Notify> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}



class AlertListTableViewController: UITableViewController {


    
    fileprivate var dataSource: SwipeableDataSource!
    
var notifications = [Notify]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.delegate = self
        
       // tableView.register(GradientTableViewCell.self, forCellReuseIdentifier: "ReminderCell")
        
        //updateSnapshot()
        
        NotificationCenter.default.addObserver(forName: LocalDatabase.UpdatedNotification, object: nil, queue: nil) { _ in
            self.updateSnapshot()
        }
        
        fetchRemiinders()
//        //test()
//
        //tableView.reloadData()
        
        print(notifications)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Reload the table view to refresh the displayed data
        //fetchRemiinders()

        tableView.reloadData()
    }
    
    func fetchRemiinders() {
        let ref = Database.database().reference()
        //let uid = Auth.auth().currentUser?.uid
    
        ref.child("user").child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("Notifications").observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            
            for child in result {
                
                let key = child.key
                let value = child.value as? NSDictionary
            
                
                guard let subject = value!["subject"] as? String, let desc = value!["desc"] as? String,let date = value!["date"] as? String, let time = value!["time"] as? String, let isReminder = value!["hasReminder"] as? Bool else { return }
//                , let time = value!["time"] as? String
                
               // var uuID = UUID(uuidString: key.replacingOccurrences(of: "not-", with: ""))
                
                self.notifications.append(Notify(idStr: key, subject: subject, description: desc, date: date, time: time, isReminder: isReminder ))
                
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let spacing: CGFloat = 100 // Set the desired spacing between cells
        
        // Return the sum of the default height and the spacing for each row
        return tableView.rowHeight + spacing
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath) as! GradientTableViewCell
        
        
        let alrt = notifications[indexPath.row]
        
//        var content = cell.defaultContentConfiguration()
        
//            content.text = alrt.payee
        //content.text = alrt.subject
        
//            content.secondaryText = String(format: "%@ - Due: %@", arguments: [(alrt.amount ?? 0).formatted(.currency(code: "usd")), alrt.formattedDueDate])
        
        //content.secondaryText = "\(alrt.description) - \(alrt.date) : \(alrt.time)"
                
        //content.directionalLayoutMargins = .init(top: 20.0, leading: 10.0, bottom: 20.0, trailing: 10.0)
        
//        cell.titleLabel.text = alrt.subject
//        cell.subtitleLabel.text = "\(alrt.description) - \(alrt.date) : \(alrt.time)"
        // Access the label inside the stack view using the outlet
        cell.vStackView.layer.cornerRadius = 20
        cell.vStackView.clipsToBounds = true
        
        cell.titleLabel.text = alrt.subject
        cell.subtitleLabel.text = "\(alrt.description) - \(alrt.date) : \(alrt.time)"
        
        for subview in cell.vStackView.arrangedSubviews {
            // Check if the subview is a label
            if let label = subview as? UILabel {
                // Adjust the layout margins to add the right margin
                label.layoutMargins.right = 100 // Update the value as per your requirement
            }
        }
        
        cell.titleLabel.layoutMargins.right = 400
        cell.subtitleLabel.layoutMargins.right = 77
        
//        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Notify>()
        snapshot.appendSections([0])
        snapshot.appendItems(LocalDatabase.shared.Alerts, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    

    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "حـذف") { (contextualAction, view, completionHandler) in
            
//            guard let alert = self.dataSource.itemIdentifier(for: indexPath) else { return }
            let alert = self.notifications[indexPath.row]
                
           
            self.notifications.remove(at: indexPath.row)
            tableView.reloadData()
            
            
                //            LocalDatabase.shared.delete(alert: alert)
                //            LocalDatabase.shared.save()
                //            self.updateSnapshot()
                
                // Assuming you have a Firebase reference and user ID
                let userId = " UaNyISDxSpgTQUidtkb23z5n0Ct2"
                let ref = Database.database().reference().child("user").child(userId).child("Notifications").child(String(alert.idStr ?? ""))
                //let alertRef = ref.childByAutoId()
            
           
            
                ref.removeValue { error, _ in
                    
                    print(error)
                }
            
         
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
 
    
    
    
//old: accessary : details
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        performSegue(withIdentifier: "alertDetail", sender: indexPath)
//    }
    
    //if clicking on cell will move to alertDetailsViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //for test
        //performSegue(withIdentifier: "alertDetail", sender: nil)
        
        let alert = notifications[indexPath.row]
        
        print("\(alert.subject) \(indexPath)")
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if let indexPath = sender as? IndexPath, segue.identifier == "alertDetail" {
//            let navigationController = segue.destination as? UINavigationController
//            let AlertDetailTableViewController = navigationController?.viewControllers.first as? AlertDetailTableViewController
//            AlertDetailTableViewController?.alert = LocalDatabase.shared.Alerts[indexPath.row]
//        }
        
        if let indexPath = sender as? IndexPath, segue.identifier == "alertDetail" {
            
            print(notifications[indexPath.row])
            
            let navigationController = segue.destination as? UINavigationController
            let AlertDetailTableViewController = navigationController?.viewControllers.first as? AlertDetailTableViewController
            AlertDetailTableViewController?.alert = notifications[indexPath.row]
            
           
        }
    }
    
    
 
    @IBSegueAction func addEditAlerts(_ coder: NSCoder, sender: Any?) -> AlertDetailTableViewController? {
       
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                 // Editing alert
                 let alertToEdit = notifications[indexPath.item]
                 return AlertDetailTableViewController(coder: coder, alert:alertToEdit)
             } else {
                 // Adding alert
                 return AlertDetailTableViewController(coder: coder, alert: nil)
             }
            
    }
    
    
    //    todo next time
//    func indexPath(for alert: Notify) -> IndexPath? {
//        if let sectionIndex = sections.firstIndex(where: { $0.subject == alert.subject }),
//            let index = sections[sectionIndex].notifications.firstIndex(where: { $0 == alert })
//        {
//            return IndexPath(item: index, section: sectionIndex)
//        }
//
//        return nil
//    }
    
//    func indexPath(for alert: Notify) -> IndexPath? {
//        if let sectionIndex = sections.firstIndex(where: { $0.subject == alert.subject }),
//            let index = sections[sectionIndex].notifications.firstIndex(where: { $0 == alert })
//        {
//            return IndexPath(row: index, section: sectionIndex)
//        }
//        return nil
//    }
    
    

    @IBAction func unwindToAlertListView(segue: UIStoryboardSegue) {
     
        guard segue.identifier == "saveUnwind",
                let sourceViewController = segue.source
                   as? AlertDetailTableViewController,
                let alert = sourceViewController.alert else { return }
        
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                notifications[selectedIndexPath.row] = alert
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                //Emoji.saveToFile(emojis: emojis)
                
        
                // Assuming you have a Firebase reference and user ID
                let userId = " UaNyISDxSpgTQUidtkb23z5n0Ct2"
                let ref = Database.database().reference().child("user").child(userId).child("Notifications").child(String(alert.idStr ?? ""))
                //let alertRef = ref.childByAutoId()

                ref.updateChildValues(alert.dictionaryRepresentation()) { (error, _) in
                    if let error = error {
                        // Handle the error
                        print("Error updating alert in Firebase: \(error.localizedDescription)")
                    } else {
                        // Alert updated successfully
                        print("Alert updated in Firebase")
                    }
                }
                
                //end if
            } else {
                let newIndexPath = IndexPath(row: notifications.count, section: 0)
                notifications.append(alert)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                //Emoji.saveToFile(emojis: emojis)
                
                var alrt = alert ?? Notify(id: UUID(), idStr: "")
                

                
//
//                guard let subject = sourceViewController.payeeTextField.text,
//                      let description = sourceViewController.amountTextField!.text,
//                      let remindDate = remindDateFormatter.string(from: sourceViewController.remindDatePicker.date) as? String ,
//                      let hasReminder =  sourceViewController.remindSwitch.isOn ? 1 : 0 else { return }
//
//                alrt.subject = subject
//                alrt.description = description
//                alrt.date = remindDate
                //alrt.paidDate = hasReminder
        //
        //        guard let subject = value!["subject"] as? String, let desc = value!["desc"] as? String,let date = value!["date"] as? String, let time = value!["time"] as? String  else { return }
        //
        //        self.notifications.append(Notify(idStr: "", subject: subject, description: desc, date: date, time: time))
                
                // Assuming you have a Firebase reference and user ID
                let ref = Database.database().reference().child("user").child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("Notifications").child("Not-\(UUID())")
                let alertRef = ref.childByAutoId()

                ref.setValue(alrt.dictionaryRepresentation()) { (error, _) in
                    
                    if let error = error {
                        // Handle the error
                        print("Error adding alert to Firebase: \(error.localizedDescription)")
                    } else {
                        // Alert added successfully
                        print("Alert added to Firebase")
                        
//                        if let destinationVC = segue.destination as? AlertListTableViewController {
//                               // Pass the necessary data to the destination view controller
//                           // destinationVC.fetchRemiinders()
//                            //destinationVC.notifications.append(alrt)
//                            destinationVC.tableView.reloadData()
//                           }
                    }
                }
                
                
                
            }//end of else
    }
    
    
    
    
    //ent only test function
    
    func test()
    {
        let ref = Database.database().reference()
        //let uid = Auth.auth().currentUser?.uid
        
        ref.child("user").child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("Notifications").observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for child in result {
                let key = child.key
                let value = child.value as? NSDictionary
                
//                let key = child("Notifications").key
//                let value = child.value as? NSDictionary
                
//                let sub = value!["subject"] as? String
            
                //print(key)
                print(value!["subject"])
//                print(sub)
            }
        })
    }
    

    // end of the class
}

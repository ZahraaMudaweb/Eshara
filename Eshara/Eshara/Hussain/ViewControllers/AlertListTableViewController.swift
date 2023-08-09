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
        
        //updateSnapshot()
        
        NotificationCenter.default.addObserver(forName: LocalDatabase.UpdatedNotification, object: nil, queue: nil) { _ in
            self.updateSnapshot()
        }
        
        fetchRemiinders()
        test()
    }
    
    func fetchRemiinders() {
        let ref = Database.database().reference()
        //let uid = Auth.auth().currentUser?.uid
    
        ref.child("user").child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("Notifications").observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            
            for child in result {
                
                let key = child.key
                let value = child.value as? NSDictionary
            
                
                guard let subject = value!["subject"] as? String, let desc = value!["desc"] as? String,let date = value!["date"] as? String, let time = value!["time"] as? String  else { return }
                    
                self.notifications.append(Notify(idStr: "", subject: subject, description: desc, date: date, time: time))
                
            }
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let spacing: CGFloat = 75 // Set the desired spacing between cells
        
        // Return the sum of the default height and the spacing for each row
        return tableView.rowHeight + spacing
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        
        let alrt = notifications[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        
//            content.text = alrt.payee
        content.text = alrt.subject
        
//            content.secondaryText = String(format: "%@ - Due: %@", arguments: [(alrt.amount ?? 0).formatted(.currency(code: "usd")), alrt.formattedDueDate])
        
        content.secondaryText = "\(alrt.description) - \(alrt.date) : \(alrt.time)"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Notify>()
        snapshot.appendSections([0])
        snapshot.appendItems(LocalDatabase.shared.Alerts, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, completionHandler) in
            
            guard let alert = self.dataSource.itemIdentifier(for: indexPath) else { return }
            LocalDatabase.shared.delete(alert: alert)
            LocalDatabase.shared.save()
            self.updateSnapshot()
            
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
        
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "alertDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if let indexPath = sender as? IndexPath, segue.identifier == "alertDetail" {
//            let navigationController = segue.destination as? UINavigationController
//            let AlertDetailTableViewController = navigationController?.viewControllers.first as? AlertDetailTableViewController
//            AlertDetailTableViewController?.alert = LocalDatabase.shared.Alerts[indexPath.row]
//        }
        
        if let indexPath = sender as? IndexPath, segue.identifier == "alertDetail" {
            let navigationController = segue.destination as? UINavigationController
            let AlertDetailTableViewController = navigationController?.viewControllers.first as? AlertDetailTableViewController
            AlertDetailTableViewController?.alert = notifications[indexPath.row]
        }
    }
    
    @IBAction func unwindFromBillDetail(segue: UIStoryboardSegue) { }
    
    
    
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
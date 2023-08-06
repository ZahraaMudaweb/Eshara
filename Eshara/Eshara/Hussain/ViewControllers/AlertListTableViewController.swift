//
//  AlertListTableViewController.swift
//  Eshara
//
//  Created by iOSdev on 02/08/2023.
//

import UIKit
import CoreData

private class SwipeableDataSource: UITableViewDiffableDataSource<Int, Notify> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}


class AlertListTableViewController: UITableViewController {


    fileprivate var dataSource: SwipeableDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        dataSource = SwipeableDataSource(tableView: tableView) { tableView, indexPath, bill in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
            
            let alrt = Database.shared.Alerts[indexPath.row]
            
            var content = cell.defaultContentConfiguration()
            
            content.text = alrt.payee
            
            content.secondaryText = String(format: "%@ - Due: %@", arguments: [(alrt.amount ?? 0).formatted(.currency(code: "usd")), alrt.formattedDueDate])
            
            cell.contentConfiguration = content
            
            return cell
        }
        
        tableView.dataSource = dataSource
        
        updateSnapshot()
        
        NotificationCenter.default.addObserver(forName: Database.UpdatedNotification, object: nil, queue: nil) { _ in
            self.updateSnapshot()
        }
    }
    
    func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Notify>()
        snapshot.appendSections([0])
        snapshot.appendItems(Database.shared.Alerts, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, completionHandler) in
            
            guard let alert = self.dataSource.itemIdentifier(for: indexPath) else { return }
            Database.shared.delete(alert: alert)
            Database.shared.save()
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
        
        if let indexPath = sender as? IndexPath, segue.identifier == "alertDetail" {
            let navigationController = segue.destination as? UINavigationController
            let AlertDetailTableViewController = navigationController?.viewControllers.first as? AlertDetailTableViewController
            AlertDetailTableViewController?.alert = Database.shared.Alerts[indexPath.row]
        }
    }
    
    @IBAction func unwindFromBillDetail(segue: UIStoryboardSegue) { }
    

    // end of the class
}

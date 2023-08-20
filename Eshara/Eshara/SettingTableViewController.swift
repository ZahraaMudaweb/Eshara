//
//  SettingTableViewController.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 03/08/2023.
//

import UIKit

class SettingTableViewController: UITableViewController {
    var setting = [Setting]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedSetting = Setting.loadFromFile() {
            setting = savedSetting
        } else {
            setting = Setting.loadSampleSetting()
        }
        
       
        tableView.estimatedRowHeight = 44.0
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshControlActivated(sender: )), for: .valueChanged)
       
    }
    @objc func refreshControlActivated(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return setting.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "SettingCell", for: indexPath) as! SettingTableViewCell
        
        let setting = setting[indexPath.row]
        
        
        cell.update(with: setting)
        cell.showsReorderControl = true
        
        
        return cell
    }
    
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    Setting.saveToFile(setting: setting)
    }
        
    @IBAction func saveSetting(_ sender: Any) {
        
        Setting.saveToFile(setting: setting)
        
        
    }

}

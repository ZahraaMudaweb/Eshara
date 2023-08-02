//
//  SettingTableViewCell.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 03/08/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

   
    @IBOutlet var switche: UISwitch!
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with setting: Setting) {
       
        label.text = setting.name
        switche.isOn = setting.switche
    }

}

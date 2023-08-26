//
//  SettingTableViewCell.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 03/08/2023.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase
import FirebaseStorage

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
        
       /* if label.text == "الإشعارات" && switche.isOn == true{
            
        }
        if label.text == "الأصوات" && switche.isOn == true{
            
        }
        if label.text == "الإعلانات" && switche.isOn == true{
            
        }
        if label.text == "الوصول للموقع" && switche.isOn == true{
            
        }*/
        
        
        
    }

}

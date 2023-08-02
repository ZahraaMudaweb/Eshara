//
//  setting.swift
//  Eshara
//
//  Created by Manar Mahfoodh on 03/08/2023.
//


import Foundation

class Setting: NSObject, NSCoding {
    var name: String
    var switche: Bool
   
    
    struct PropertyKey {
       
        static let name = "name"
        static let switche = "switche"
       
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("setting")
    
    init(switche: Bool, name: String ) {
       
        self.name = name
        self.switche = switche
        
    }
    
    static func loadFromFile() -> [Setting]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Setting.ArchiveURL.path) as? [Setting]
    }
    
    static func loadSampleSetting() -> [Setting] {
        return [Setting(switche: false, name: "الإشعارات"),
                Setting(switche: true, name: "الأصوات"),
                Setting(switche: false, name: "الإعلانات"),
                Setting(switche: false, name: "الوصول للموقع")
                ]
    }
    
    static func saveToFile(setting: [Setting]) {
        NSKeyedArchiver.archiveRootObject(setting, toFile: Setting.ArchiveURL.path)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String,
            
            let switche = aDecoder.decodeObject(forKey: PropertyKey.switche) as? Bool
            
        else {
                return nil
        }
        
        self.init(switche: switche, name: name)
    }
    
    func encode(with aCoder: NSCoder) {
       
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(switche, forKey: PropertyKey.switche)
       
    }
}

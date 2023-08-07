//
//  FireBaseViewController.swift
//  Eshara
//
//  Created by iOSdev on 07/08/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FireBaseViewController: UIViewController
{

    
    @IBOutlet var Name: UILabel!
    
    
    
    @IBOutlet var Price: UILabel!
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        TeacherInfo()
    }
    

    
    func TeacherInfo()
    {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        
        
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

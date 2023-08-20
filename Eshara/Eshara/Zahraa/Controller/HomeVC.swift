//
//  HomeVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 20/08/2023.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var teachers: UIView!
    @IBOutlet var lessons: UIView!
    @IBOutlet var friends: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teachers.layer.cornerRadius = 20
        teachers.layer.masksToBounds = true
        lessons.layer.cornerRadius = 20
        lessons.layer.masksToBounds = true
        friends.layer.cornerRadius = 20
        friends.layer.masksToBounds = true
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

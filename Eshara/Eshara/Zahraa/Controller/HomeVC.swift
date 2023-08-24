//
//  HomeVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 20/08/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeVC: UIViewController {

    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var heartsLabel: UILabel!
    @IBOutlet var teachers: UIView!
    @IBOutlet var lessons: UIView!
    @IBOutlet var friends: UIView!
    
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateHearts()
        updatePoints()
        
        teachers.layer.cornerRadius = 20
        teachers.layer.masksToBounds = true
        lessons.layer.cornerRadius = 20
        lessons.layer.masksToBounds = true
        friends.layer.cornerRadius = 20
        friends.layer.masksToBounds = true
    }
    
    func updateHearts() {
        let uid = Auth.auth().currentUser?.uid
        if uid != nil {
            ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
                snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
                
                for child in result {
                    if child.key == "hearts" {
                        guard let value = child.value as? Int else {return}
                        self.heartsLabel.text = "\(value)"
                    }
                }
            })}
    }
    
    func updatePoints() {
        let uid = Auth.auth().currentUser?.uid
        if uid != nil {
            ref.child("user").child(uid!).observeSingleEvent(of: .value, with: {
                snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
                
                for child in result {
                    if child.key == "points" {
                        guard let value = child.value as? Int else {return}
                        self.pointsLabel.text = "\(value)"
                    }
                }
            })}
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

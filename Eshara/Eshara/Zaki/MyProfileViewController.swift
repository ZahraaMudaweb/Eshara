//
//  MyProfileViewController.swift
//  Eshara
//
//  Created by iOSdev on 22/08/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBAction func addFriend(_ sender: UIButton) {
    }
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var imgPlayer: UIImageView!
      
    @IBOutlet weak var myProfile: UICollectionView!
    
    var reviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getReviews()
    }
    
    func getReviews() {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
//        ref.child("user").child(uid!).child("Review").observeSingleEvent(of: .value, with: {
        ref.child("user").child(uid!).child("Review").observeSingleEvent(of: .value, with: {
            (snapshot) in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for review in result {
                let value = review.value as? NSDictionary
                
                let name = value!["Name"] as! String
                
                self.reviews.append(Review(name: name, rate: "", comment: ""))
            }
            
            self.myProfile.reloadData()
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! MyProfileCollectionViewCell
        
        let comment = reviews[indexPath.row]
        
        cell.playerName.text = comment.name
        
        return cell
    }

    

}

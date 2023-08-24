//
//  LeaderBoardViewController.swift
//  Eshara
//
//  Created by iOSdev on 22/08/2023.
//

import UIKit
import FirebaseDatabase

class LeaderBoardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var imgPlayer3: UIImageView!
    @IBOutlet weak var pointPlayer3: UILabel!
    @IBOutlet weak var namePlayer3: UILabel!
    
    @IBOutlet weak var imgPlayer1: UIImageView!
    @IBOutlet weak var pointPlayer1: UILabel!
    @IBOutlet weak var namePlayer1: UILabel!
    
    @IBOutlet weak var imgPlayer2: UIImageView!
    @IBOutlet weak var pointPlayer2: UILabel!
    @IBOutlet weak var namePlayer2: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var leaderboards = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getLeaderboardInformation()

        // Do any additional setup after loading the view.
    }
    
    func getLeaderboardInformation() {
        let ref = Database.database().reference()
        
        
        
        ref.child("user").observeSingleEvent(of: .value, with: {
            snapshot in guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for user in result {
                
                let value = user.value as? NSDictionary
                if let points = value?["points"] as? Int
                {
                    self.leaderboards.append(User(name: value?["Name"] as! String , image: "", points: points , ranking: ""))

                }
                
            }
            
            self.leaderboards = self.leaderboards.sorted { $0.points > $1.points }

            
            self.collectionView.reloadData()
        })
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leaderboards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leaderboardCell", for: indexPath) as! leaderBoardCollectionViewCell
        
        let user = leaderboards[indexPath.row]
        
        cell.playerPoint.text = String(user.points)
        cell.playerName.text = user.name
        cell.imgPlayer.image = UIImage(systemName: "photo")
        cell.userPlace.text = user.ranking
        
        return cell
    }
    

    

}

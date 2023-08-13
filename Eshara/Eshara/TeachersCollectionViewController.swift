//
//  TeachersCollectionViewController.swift
//  Eshara
//
//  Created by A M on 8/4/23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

private let reuseIdentifier = "Cell"

struct Notification {
    var id : String
    var subject : String
    var desc : String
    var date : String

}



class TeachersCollectionViewController: UICollectionViewController
{
   
    
    
    
    
    
    let teacherss: [Teacherdata] =
    [
            Teacherdata(teacherName: "Ali", teacherRate: 4.5, teacherLocation: "Sitra", teacherPrice: 8, color: UIColor(red: (1/255.0), green: (145/255.0), blue: (180/255.0), alpha: 1)),
            Teacherdata(teacherName: "Ahmed", teacherRate: 4, teacherLocation: "Eaker", teacherPrice: 5, color: UIColor(red: (211/255.0), green: (221/255.0), blue: (24/255.0), alpha: 1)),
            Teacherdata(teacherName: "Hussain", teacherRate: 5, teacherLocation: "Sanad", teacherPrice: 7, color: UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha: 1)),
            Teacherdata(teacherName: "Ammar", teacherRate: 3, teacherLocation: "Manamma", teacherPrice: 9, color: UIColor(red: (254/255.0), green: (122/255.0), blue: (21/255.0), alpha: 1))
        ]
    
    var notifications = [Notification]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    func generateID(prefix: String) -> String {
        let sampleId = UUID()
        
        return "\(prefix)\(sampleId)"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return teacherss.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeachersDataCollectionViewCell
        
        let teacherData = teacherss[indexPath.row]
       
        cell.nameLabel.textAlignment = .right
        
        cell.name(teacherName: teacherData.teacherName, teacherRate: teacherData.teacherRate, teacherLocation: teacherData.teacherLocation, teacherPrice: teacherData.teacherPrice)
        cell.backgroundColor = teacherData.color
        
        
       

        return cell
    }
    
    
    private func generateLayout() -> UICollectionViewLayout
    {
        view.backgroundColor = UIColor(red: (247/255.0), green: (240/255.0), blue: (245/255.0), alpha: 1)
        
        let space: CGFloat = 30
        
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
            )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
     
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(170.0)
        )   
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        group.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: 0, trailing: space)
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
     
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        let selectedTeacher = teacherss[indexPath.row]
        
        
        
        
        guard let dec = storyboard?.instantiateViewController(withIdentifier: "teacherData") as? TeachersDataViewController else {return}
        
        dec.teacher = selectedTeacher
        
        navigationController?.pushViewController(dec, animated: true)
        
                
    }
    
    
    
    
    //navigationController?.pushViewController(des, animated: true)
    
//    func teacherInfo()
//    {
//        let ref = Database.database().reference()
//
//
//        ref.child("user").child(" UaNyISDxSpgTQUidtkb23z5n0Ct2").child("Notifications").observeSingleEvent(of: .value)
//        { [self]
//            snapshot in
//            guard let result = snapshot.children.allObjects as? [DataSnapshot] else {return}
//
//            for child in result
//            {
//                let key = child.key
//                let value = child.value as? NSDictionary
//
//                let subject = value!["subject"] as! String
//                let desc = value!["desc"] as! String
//                let date = value!["date"] as! String
//
//                self.notifications.append(Notification(id: generateID(prefix: "Not-"), subject: subject, desc: desc, date: date))
//               print(key)
//                print(value)
//            }
//            print(self.notifications)
//        }
//   }
    

    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    
    
    
}

//
//  ReviewsCollectionViewController.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

private let reuseIdentifier = "Cell"


class ReviewsCollectionViewController: UICollectionViewController{

 
    
    @IBOutlet var AddRevireButton: UIBarButtonItem!
    
    
    
    
    var Student: [AddStudentrevie] =
    [    AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5"),
         AddStudentrevie(studentRate: "Ammar", StudentCommrnt: "Nice Teacher", studentname: "4"),
        AddStudentrevie(studentRate: "Hussain", StudentCommrnt: "it was fun ", studentname: "4.5")
    ]

   
    
    
 
  
    override func viewDidLoad() {
        super.viewDidLoad()

      //  AddRevireButton.isEnabled = false
        fetchDatePicker { result in
            if result == true
            {
                self.AddRevireButton.isEnabled = true
              
            }
            else
            {
                self.AddRevireButton.isEnabled = false
                
            }
        }
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    

        
      
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
            heightDimension: .absolute(150.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        group.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: 0, trailing: space)
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
     
    }
    
    
    
    
    @IBAction func AddReviewsButton(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "toAddReviews", sender: sender)
    }
    
    
    
    @IBAction func unwidtoAddRevie(segue: UIStoryboardSegue)
    {
        guard  segue.identifier == "saveButton",
               let sours = segue.source as? AddReviewViewController,
               let addCommet = sours.AddstudentRevie else {return}
        
       
       
            let newindepath = IndexPath(row: Student.count, section: 0)
            Student.append(addCommet)
            collectionView.insertItems(at: [newindepath])
     
        
    }
    
    

    
    @IBSegueAction func aa(_ coder: NSCoder, sender: Any?) -> AddReviewViewController? {
        return AddReviewViewController(coder: coder, AddstudentRevie: nil)
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
    
        return Student.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewsCollectionViewCell
    
        // Configure the cell
       
       
        let student = Student[indexPath.row]
        
        cell.update(with: student)

        return cell
    }
    
    

    
    func fetchDatePicker(completion: @escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        let todayDate = Date().formatted()

        ref.child("user").child(uid!).child("Bookmark").child("date").observe(.value) { snapshot in
            guard let firebaseDate = snapshot.value as? String else {
                
                completion(false)
                return
            }
            
            print(firebaseDate)

            if todayDate.compare(firebaseDate) == .orderedAscending {
                // The current date is earlier than the Firebase date
                completion(false)
            } else if todayDate.compare(firebaseDate) == .orderedDescending {
                // The current date is later than the Firebase date
                completion(true)
            } else {
                // The current date is equal to the Firebase date
                completion(false)
            }
        }
    }
    
    
 
    
   
    
    
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

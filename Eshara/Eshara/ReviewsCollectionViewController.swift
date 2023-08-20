//
//  ReviewsCollectionViewController.swift
//  Eshara
//
//  Created by A M on 8/15/23.
//

import UIKit

private let reuseIdentifier = "Cell"


class ReviewsCollectionViewController: UICollectionViewController{
 
    
    
    var Student: [AddStudentrevie] =
    [
        AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5"),
        AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5"),
        AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5"),
        AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5"),
        AddStudentrevie(studentRate: "Ahmed", StudentCommrnt: "nice", studentname: "5")
    ]
   
    
    

    var dataRev = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
//       

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
            heightDimension: .absolute(200.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)

        group.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: 0, trailing: space)
        
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
     
    }
    
    
    
    
    @IBAction func AddReviewsButton(_ sender: UIBarButtonItem)
    {
        if true
        {
            performSegue(withIdentifier: "AddRevi", sender: sender)

            
        }   
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
    
    
    
    @IBSegueAction func addreviedata(_ coder: NSCoder, sender: Any?) -> AddReviewViewController?
    {
       
        
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
        //collectionView.reloadData()
       
       // cell.studentName.text = studentComment
        
      //  cell.studentName.text = studentComment
       // cell.StudentComment.text = student.StudetComment
        
    //    cell.StudentRevir(StudentName: student.StudentName, StudentRate: student.StudentRate, StudentSomment: student.StudetComment)
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReviewsCollectionViewCell
        print("Press")
     
        cell.StudentName.text = dataRev
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

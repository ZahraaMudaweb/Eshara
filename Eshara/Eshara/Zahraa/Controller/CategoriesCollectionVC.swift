//
//  CategoriesCollectionVC.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 02/08/2023.
//

import UIKit

private let reuseIdentifier = "Category"
let spacing: CGFloat = 20

let categories = ["الــــعـــــائــــلـــــة", "الـــمـــحـــادثـــات", "فــي الــمـــدرســـة", "في المستشفى", "فــي الــمـنـــزل", "الـــحـــيـــوانـــات"]

class CategoriesCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        refreshConrol.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }

//    var refreshConrol = UIRefreshControl()
//    @objc func refresh(send: UIRefreshControl) {
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//            self.refreshConrol.endRefreshing()
//        }
//    }
    
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let categoryCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as? CategoryCollectionViewCell {
            
            categoryCell.configure(with: categories[indexPath.row])
            cell = categoryCell
            cell.layer.cornerRadius = 20
            cell.layer.masksToBounds = true
            collectionView.contentInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
 
            if indexPath.item % 2 == 0 && indexPath.item != 2 || indexPath.item == 3 {
                cell.contentView.backgroundColor = yellow
                cell.backgroundColor = yellow
            } else {
                cell.contentView.backgroundColor = green
                cell.backgroundColor = green
            }
        }
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        guard let vc = storyboard?.instantiateViewController(identifier: "stages") as? StagesVC else {return}
        
        vc.categoryName = categories[indexPath.row]
        vc.itemIndex = indexPath.item
        
        navigationController?.pushViewController(vc, animated: true)
        
        guard let vcQuiz = storyboard?.instantiateViewController(identifier: "videoQuiz") as? VideoQuizVC else {return}
        
        vcQuiz.itemIndex = indexPath.row
        vcQuiz.categoryName = categories[indexPath.row]
       
    }
}



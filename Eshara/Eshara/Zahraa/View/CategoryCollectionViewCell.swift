//
//  CategoryCollectionViewCell.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 02/08/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var categoryIcon: UIImageView!
    @IBOutlet var categoryTitle: UILabel!
    
    func configure(with categoryName: String) {
        categoryTitle.text = categoryName
        categoryTitle.text = categoryName
        categoryIcon.image = UIImage(named: categoryName)
    }
}

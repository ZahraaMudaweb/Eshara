//
//  CatrgoryVFL.swift
//  Eshara
//
//  Created by Zahraa AlMudaweb on 03/08/2023.
//

import UIKit

class CatrgoryVFL: UICollectionViewFlowLayout {
    
    let padding: CGFloat = 15.0
    let spacing: CGFloat = 8.0
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        minimumInteritemSpacing = spacing
        minimumLineSpacing = padding
        sectionInset = UIEdgeInsets(top: padding, left: spacing, bottom: padding, right: spacing)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        return attributes
    }

}

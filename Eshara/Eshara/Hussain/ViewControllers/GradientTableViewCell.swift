//
//  GradientTableViewCell.swift
//  Eshara
//
//  Created by iOSdev on 10/08/2023.
//

import UIKit

class GradientTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var vStackView: UIStackView!
    
    
    let gradientLayer = CAGradientLayer()
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Create a gradient with desired colors
//        let gradientColors = [UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 20.0).cgColor,
//                              UIColor(red: (248/255.0), green: (217/255.0), blue: (15/255.0), alpha:1).cgColor,
//                              UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 40.0).cgColor]
//
//        // Set up the gradient layer with proper frame and colors
//        gradientLayer.frame = contentView.bounds
//        gradientLayer.colors = gradientColors
//
//        // Set locations for sharper gradient
//        gradientLayer.locations = [0.2, 0.4] // Adjust these values to control sharpness
//
//        // Add the gradient layer as the background layer of the cell's contentView
//        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  LikedGridCell.swift
//  insteadOfLab6
//
//  Created by Matt Haynes on 4/15/22.
//

import UIKit

class LikedGridCell: UICollectionViewCell {
    
    var cornerRadius: CGFloat = 5.0

        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 8.0
            layer.shadowOpacity = 0.10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
        }
    
}

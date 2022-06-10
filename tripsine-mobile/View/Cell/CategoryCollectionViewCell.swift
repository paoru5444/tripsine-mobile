//
//  CategoryCollectionViewCell.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerInsetView: UIView!
    
    
    
    func setupCell() {
        print("Here")
        containerInsetView.layer.cornerRadius = 8
        
        containerInsetView.backgroundColor = .white
        containerInsetView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        containerInsetView.layer.shadowOpacity = 1
        containerInsetView.layer.shadowRadius = 4
        containerInsetView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

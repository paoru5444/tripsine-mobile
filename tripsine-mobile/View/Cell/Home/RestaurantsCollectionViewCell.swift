//
//  RestaurantsCollectionViewCell.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 10/06/22.
//

import UIKit

class RestaurantsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var openLabel: UILabel!
    
    func setupCell(index: Int, restaurantData: [RestaurantData]) {
        renderView()
        
    }
    
    private func renderView() {
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        
        openLabel.layer.cornerRadius = 8
        openLabel.layer.borderWidth = 1
        openLabel.layer.borderColor = UIColor(red: 0.298, green: 0.686, blue: 0.314, alpha: 1).cgColor
        
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

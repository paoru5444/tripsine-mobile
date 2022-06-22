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
    @IBOutlet weak var restaurantTittleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(index: Int, restaurantData: RestaurantData) {
        renderView()
        
        restaurantTittleLabel.text = restaurantData.name
        descriptionLabel.text = restaurantData.address
        priceLabel.text = restaurantData.price
        openLabel.text = "\(shouldUpdateStatus(data: restaurantData))"
        rateLabel.text = "/ \(updateRating(data: restaurantData))"
        
        
        if let url = URL(string: restaurantData.photo?.image?.original?.url ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                image.image = UIImage(data: imageData)
            }
        }
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
    
    private func shouldUpdateStatus(data: RestaurantData) -> String {
        let isOpen = data.isOpen
        if isOpen {
            return "OPEN"
        } else {
            return "CLOSED"
        }
    }
    
    private func updateRating(data: RestaurantData) -> String {
        guard let rating = data.rating else { return String()}
        return rating
    }
    
}

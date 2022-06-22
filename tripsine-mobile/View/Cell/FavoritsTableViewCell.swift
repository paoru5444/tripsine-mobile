//
//  FavoritsTableViewCell.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit

class FavoritsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var nameRestaurantLabel: UILabel!
    @IBOutlet weak var nameLocalLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderView()
    }
    
    func setupCustomCell(data: [RestaurantData]) {
        guard let rating = data.first?.rating else { return }
        
        priceLabel.text = data.first?.price
        nameRestaurantLabel.text = data.first?.name
        nameLocalLabel.text = data.first?.address
        ratingLabel.text = "/\(rating)"
        
        if let url = URL(string: data.first?.photo?.image?.original?.url ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                restaurantImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func shouldUpdateStatus(data: [RestaurantData]) -> String {
        guard let isOpen = data.first?.isOpen else { return String() }
        if isOpen {
            return "OPEN"
        } else {
            return "CLOSED"
        }
    }
    
    private func renderView() {
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 8
        
        restaurantImage.clipsToBounds = true
        restaurantImage.layer.masksToBounds = true
        restaurantImage.layer.cornerRadius = 8
        
        containerView.layer.cornerRadius = 8
        
        containerView.backgroundColor = .white
        containerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

}

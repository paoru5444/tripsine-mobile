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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    func setupCustomCell() {
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

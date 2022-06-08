//
//  FavoritsTableViewCell.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit

class FavoritsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("aqui")
        cellView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cellView.layer.shadowOpacity = 10
        cellView.layer.shadowRadius = 40
        cellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cellView.layer.backgroundColor = UIColor(red: 248, green: 248, blue: 248, alpha: 1).cgColor
        
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 8
        
//        restaurantImage.clipsToBounds = true
        
        restaurantImage.layer.masksToBounds = true
        restaurantImage.layer.cornerRadius = 8
    }
    
    func setupCustomCell() {
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

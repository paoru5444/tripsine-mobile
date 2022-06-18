//
//  CategoryCollectionViewCell.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerInsetView: UIView!
    @IBOutlet weak var iconCategorieImage: UIImageView!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    func setupCell(index: Int) {
        containerInsetView.layer.cornerRadius = 8
        
        containerInsetView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        containerInsetView.layer.shadowOpacity = 1
        containerInsetView.layer.shadowRadius = 4
        containerInsetView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        if (index == 0) {
            containerInsetView.backgroundColor = UIColor(red: 0.816, green: 0.067, blue: 0.063, alpha: 1)
            iconCategorieImage.image = UIImage(named: "chef-hat-icon")
            itemCategoryLabel.text = "Restaurantes"
            itemCategoryLabel.textColor = .white
        }
        
        if (index == 1) {
            containerInsetView.backgroundColor = .white
            iconCategorieImage.image = UIImage(named: "beer_icon")
            itemCategoryLabel.text = "Bars & Pubs"
        }
        
        if (index == 2) {
            containerInsetView.backgroundColor = .white
            iconCategorieImage.image = UIImage(named: "coffe-icon")
            itemCategoryLabel.text = "Coffee & Tea"
        }
    }
    
    func setupData(model: HomeCategoryModel) {
        itemCategoryLabel.text = model.filters.filterSection.label
    }
}

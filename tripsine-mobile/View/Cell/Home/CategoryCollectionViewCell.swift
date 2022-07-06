//
//  CategoryCollectionViewCell.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

private enum CategoryImage: String {
    case cuisineType = "cuisineType"
    case dietaryRestriction = "dietaryRestriction"
    case meals = "meals"
    case estabileshimentType = "estabileshimentType"
    case miniumTravelRaiting = "miniumTravelRaiting"
    case restaurantFeature = "more"
    
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerInsetView: UIView!
    @IBOutlet weak var iconCategorieImage: UIImageView!
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    func setupCell(index: Int, filterSection: [FilterSection]) {
        renderView()
        
        if index >= 1 {
            containerInsetView.backgroundColor = .white
            iconCategorieImage.image = UIImage(named: renderImageSection(section: filterSection[index].section))
            itemCategoryLabel.text = filterSection[index].description
            iconCategorieImage.tintColor = .red
            itemCategoryLabel.numberOfLines = 0
            itemCategoryLabel.textColor = .black
            self.backgroundColor = .white
        } else {
            containerInsetView.backgroundColor = UIColor(red: 0.816, green: 0.067, blue: 0.063, alpha: 1)
            iconCategorieImage.image = UIImage(named: "chef-hat")
            itemCategoryLabel.text = filterSection.first?.description
            itemCategoryLabel.textColor = .white
            self.backgroundColor = .purple
        }
    }
    
    private func renderView() {
        containerInsetView.layer.cornerRadius = 8
        containerInsetView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        containerInsetView.layer.shadowOpacity = 1
        containerInsetView.layer.shadowRadius = 4
        containerInsetView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    private func renderImageSection(section: String) -> String {
        switch section {
        case "combined_food":
            return CategoryImage.cuisineType.rawValue
        case "dietary_restrictions":
            return CategoryImage.dietaryRestriction.rawValue
        case "restaurant_mealtype":
            return CategoryImage.meals.rawValue
        case "restaurant_tagcategory":
            return CategoryImage.estabileshimentType.rawValue
        case "min_rating":
            return CategoryImage.miniumTravelRaiting.rawValue
        case "restaurant_features":
            return CategoryImage.restaurantFeature.rawValue
        default:
            return String()
        }
    }
    
}

//
//  HomeViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var searchRestaurantTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    
    let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        restaurantsCollectionView.dataSource = self
        renderView()
        renderSearchTextField()
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        renderImageTextField()
        categoryViewModel.makeRequest()
    }
    
    private func renderImageTextField() {
        searchRestaurantTextField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 10,
                                                  y: 10,
                                                  width: 20,
                                                  height: 20))
        let image = UIImage(named: "search icon" )
        imageView.image = image
        searchRestaurantTextField.leftView = imageView
    }
    
    private func renderSearchTextField() {
        searchRestaurantTextField.layer.cornerRadius = 8
        searchRestaurantTextField.backgroundColor = .white
        searchRestaurantTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        searchRestaurantTextField.layer.shadowOpacity = 1
        searchRestaurantTextField.layer.shadowRadius = 4
        searchRestaurantTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.restaurantsCollectionView {
            return 8
        }
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryIdentifier", for: indexPath) as! CategoryCollectionViewCell
            
            if indexPath.row == 0 {
                setupLayerCell(cell: categoryCell)
                categoryCell.backgroundColor = .purple
                categoryCell.setupCell(index: indexPath.row)
            } else {
                setupLayerCell(cell: categoryCell)
                categoryCell.backgroundColor = .white
                categoryCell.setupCell(index: indexPath.row)
            }
            
            return categoryCell
        } else {
            let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantsCollectionViewCell
            restaurantCell.setupCell()
            return restaurantCell
        }
    }
    
    private func setupLayerCell(cell: UICollectionViewCell) {
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.red.cgColor
    }
}

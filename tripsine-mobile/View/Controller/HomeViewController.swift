//
//  HomeViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var searchRestaurantTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    
    let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    var filterSection = [FilterSection]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        restaurantsCollectionView.dataSource = self
        renderView()
        makeRequestForHome()
        categoryViewModel.delegate = self
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        renderImageTextField()
        renderSearchTextField()
    }
    
    private func renderImageTextField() {
        let imageView = UIImageView(frame: CGRect(x: 20,
                                                  y: 30,
                                                  width: 20,
                                                  height: 20))
        let image = UIImage(named: "search icon")
        imageView.image = image
        searchRestaurantTextField.leftView = imageView
        searchRestaurantTextField.leftViewMode = .always
    }
    
    private func renderSearchTextField() {
        searchRestaurantTextField.layer.cornerRadius = 8
        searchRestaurantTextField.backgroundColor = .white
        searchRestaurantTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        searchRestaurantTextField.layer.shadowOpacity = 1
        searchRestaurantTextField.layer.shadowRadius = 4
        searchRestaurantTextField.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func makeRequestForHome() {
        categoryViewModel.makeRequest()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.restaurantsCollectionView {
            return 8
        }
        return filterSection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryIdentifier", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.setupCell(index: indexPath.row, filterSection: filterSection)
            return categoryCell
        } else {
            let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantsCollectionViewCell
            restaurantCell.setupCell()
            return restaurantCell
        }
    }
}

extension HomeViewController: HomeCategoryViewModelDelegate {
    func updateCategory(_ filter: [FilterSection]) {
        DispatchQueue.main.async {
            self.filterSection = filter
            self.collectionView.reloadData()
        }
    }
}

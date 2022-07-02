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
    @IBOutlet weak var currentAddressLabel: UIButton!
    
    private let loadingView = LoadingView()
    let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    let mapViewController = MapViewController()
    let mapsViewModel = MapService()
    var filterSection = [FilterSection]()
    var restaurantSection: [RestaurantData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        restaurantsCollectionView.dataSource = self
        renderView()
        makeRequestForHome()
        categoryViewModel.delegate = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
        
        loadingView.loadingIndicator.isAnimating = true
        loadingView.setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadingView.loadingIndicator.isAnimating = false
        }
    }
    
    func updateHomeFromMaps(_ address: LocationResultData) {
        currentAddressLabel.setTitle(address.location_string, for: .normal)
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        renderSearchTextField()
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
        mapViewController.getAddressByCoordenates()
    }

}

extension HomeViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        currentAddressLabel.setTitle(address, for: .normal)
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.restaurantsCollectionView {
            return restaurantSection.count
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
            restaurantCell.setupCell(index: indexPath.row, restaurantData: restaurantSection[indexPath.row])
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

extension HomeViewController: HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ restaurants: [RestaurantData]) {
        DispatchQueue.main.async {
            self.restaurantSection = restaurants
            self.restaurantsCollectionView.reloadData()
        }
    }
}

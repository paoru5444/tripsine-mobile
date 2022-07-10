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
    let locationCoreDataService = LocationCoreDataService()
    
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
    func hasCoreData() -> Bool {
        let coreDataLocation = locationCoreDataService.getLocationData().first
        return coreDataLocation?.location_id != nil && coreDataLocation?.location_string != nil
    }
    
    func getInitialLocation(address: String) {
        let coreDataLocation = locationCoreDataService.getLocationData().first
        
        if let location_string = coreDataLocation?.location_string {
            currentAddressLabel.setTitle(location_string, for: .normal)
            if let location_id = coreDataLocation?.location_id {
                self.restaurantViewModel.makeRequestWithLocationId(locationId: location_id)
            }
        } else {
            currentAddressLabel.setTitle(address, for: .normal)
        }
        
        // mark: check if requests should be performed again
        if hasCoreData() { return }
        
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.locationCoreDataService.setLocationData(
                location_id: resultData.location_id,
                location_string: resultData.location_string
            )
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

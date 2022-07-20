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
    @IBOutlet weak var currentAddressLabel: UIButton!
    
    private let loadingView = LoadingView()
    private let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    private let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    private let mapViewController = MapViewController()
    private let mapsViewModel = MapService()
    private var filterSection = [FilterSection]()
    private var restaurantSection: [RestaurantData] = []
    let locationCoreData = LocationCoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderView()
        makeRequestForHome()
        collectionView.dataSource = self
        restaurantsCollectionView.dataSource = self
        categoryViewModel.delegate = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
    }
    
    func updateHomeFromMaps(_ address: LocationResultData) {
        currentAddressLabel.setTitle(address.location_string, for: .normal)
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        renderLoadingView()
    }
    
    private func renderLoadingView() {
        loadingView.loadingIndicator.isAnimating = true
        loadingView.setupUI(viewController: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.loadingView.loadingIndicator.isAnimating = false
        }
    }
    
    private func makeRequestForHome() {
        categoryViewModel.makeRequest()
        mapViewController.getAddressByCoordenates()
    }

}

extension HomeViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        if let location_string = locationCoreData.getLocationData().last?.location_string {
            currentAddressLabel.setTitle(location_string, for: .normal)
            mapsViewModel.fetchLocationIdBy(address: location_string) { resultData in
                self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
            }
        } else {
            currentAddressLabel.setTitle(address, for: .normal)
            mapsViewModel.fetchLocationIdBy(address: address) { resultData in
                self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
            }
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

extension HomeViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        currentAddressLabel.setTitle(address, for: .normal)
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
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

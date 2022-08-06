//
//  HomeViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var currentAddressButton: UIButton!
    @IBOutlet weak var searchRestaurantTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    
    private let mapViewController = MapViewController()
    private let loadingView = LoadingView()
    private let mapsViewModel = MapService()
    private var filterSection = [FilterSection]()
    private var restaurantSection: [RestaurantData] = []
    private let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    private let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    private var filterRestaurants: [RestaurantData] = []
    let locationCoreData = LocationCoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        restaurantsCollectionView.dataSource = self
        categoryViewModel.delegate = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
        
        renderView()
        makeRequestForHome()
    }
    
    @IBAction func filterTextActionButton(_ sender: UIButton) {
        guard let filterText = searchRestaurantTextField.text,
                !filterText.isEmpty else {
                    filterRestaurants = restaurantSection
                    restaurantsCollectionView.reloadData()
                    return
                }
        let results = restaurantSection.filter { $0.name?.lowercased().contains(filterText.lowercased()) ?? false }
        filterRestaurants = results
        restaurantsCollectionView.reloadData()
    }
    
    
    func updateHomeFromMaps(_ address: LocationResultData) {
        currentAddressButton.setTitle(address.location_string, for: .normal)
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        
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
            currentAddressButton.setTitle(location_string, for: .normal)
            mapsViewModel.fetchLocationIdBy(address: location_string) { resultData in
                self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
            }
        } else {
            currentAddressButton.setTitle(address, for: .normal)
            mapsViewModel.fetchLocationIdBy(address: address) { resultData in
                self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.restaurantsCollectionView {
            return filterRestaurants.count
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
            restaurantCell.setupCell(index: indexPath.row, restaurantData: filterRestaurants[indexPath.row])
            restaurantCell.contentMode = .scaleToFill
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
            self.filterRestaurants = restaurants
            self.restaurantsCollectionView.reloadData()
        }
    }
}

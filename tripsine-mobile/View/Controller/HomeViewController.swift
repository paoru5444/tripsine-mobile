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
    @IBOutlet weak var restaurantsCollectionView: UICollectionView!
    
    private let mapViewController = MapViewController()
    private let loadingView = LoadingView()
    private let mapsViewModel = MapService()
    private var restaurantSection: [RestaurantData] = []
    private var filterRestaurants: [RestaurantData] = []
    private let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()

    let locationCoreData = LocationCoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantsCollectionView.dataSource = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
        
        renderView()
        makeRequestForHome()
    }
    
    @IBAction func filterTextActionButton(_ sender: UIButton) {
        guard let filterText = searchRestaurantTextField.text,
                !filterText.isEmpty
        else {
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
        mapViewController.getAddressByCoordenates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController = segue.destination as? DetailsViewController
        else { return }
        filterRestaurants = restaurantSection

        detailViewController.nameText = filterRestaurants.first?.name ?? String()
        detailViewController.addressText = filterRestaurants.first?.address ?? String()
        detailViewController.descriprionText = filterRestaurants.first?.description ?? String()
        detailViewController.ratingText = filterRestaurants.first?.rating ?? String()
        detailViewController.priceText = filterRestaurants.first?.price ?? String()
        detailViewController.emailText = filterRestaurants.first?.email ?? String()
        detailViewController.urlText = filterRestaurants.first?.website ?? String()
        detailViewController.isOpen = "OPEN"

        if let url = URL(string: filterRestaurants.first?.photo?.image?.original?.url ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                detailViewController.iconImage = UIImage(data: imageData) ?? UIImage()
            }
        }
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
        return filterRestaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restaurantCell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantsCollectionViewCell
        restaurantCell.setupCell(index: indexPath.row, restaurantData: filterRestaurants[indexPath.row])
        restaurantCell.contentMode = .scaleToFill
        return restaurantCell
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

//
//  FilterViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 24/06/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var isOpenLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private let categoryViewModel: HomeCategoryViewModel = HomeCategoryViewModel()
    private let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    private let mapViewController = MapViewController()
    private let mapsViewModel = MapService()
    private var filterSection = [FilterSection]()
    private var restaurantSection: [RestaurantData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequestForHome()
        renderView()
        categoryViewModel.delegate = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
    }
    
    @IBAction func didSendData(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateHomeFromMaps(_ address: LocationResultData) {
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func makeRequestForHome() {
        categoryViewModel.makeRequest()
        mapViewController.getAddressByCoordenates()
    }
    
    private func renderView() {
        categoryLabel.layer.borderWidth = 1
        ratingLabel.layer.borderWidth = 1
        mealLabel.layer.borderWidth = 1
        isOpenLabel.layer.borderWidth = 1
        priceLabel.layer.borderWidth = 1
        
        filterButton.layer.cornerRadius = 10
        categoryLabel.layer.cornerRadius = 2
        ratingLabel.layer.cornerRadius = 2
        mealLabel.layer.cornerRadius = 2
        isOpenLabel.layer.cornerRadius = 2
        priceLabel.layer.cornerRadius = 2
    }
    
}

extension FilterViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String?) {
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
        }
    }
}

extension FilterViewController: HomeCategoryViewModelDelegate {
    func updateCategory(_ filter: [FilterSection]) {
        DispatchQueue.main.async {
            self.filterSection = filter
            self.categoryLabel.text = filter.first?.section
        }
    }
}

extension FilterViewController: HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ restaurants: [RestaurantData]) {
        DispatchQueue.main.async {
            self.restaurantSection = restaurants
            self.ratingLabel.text = restaurants.first?.rating
            self.isOpenLabel.text = "\(String(describing: restaurants.first?.isOpen))"
            self.priceLabel.text = restaurants.first?.price
        }
    }
}

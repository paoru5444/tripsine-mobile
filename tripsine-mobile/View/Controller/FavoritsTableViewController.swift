//
//  FavoritsTableViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit

class FavoritsTableViewController: UITableViewController {
    
    private let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    private let mapViewController = MapViewController()
    private let mapsViewModel = MapService()
    private var restaurantSection: [RestaurantData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
        
        makeRequestForMapView()
    }

    func updateHomeFromMaps(_ address: LocationResultData) {
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func makeRequestForMapView() {
        mapViewController.getAddressByCoordenates()
    }
}

extension FavoritsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantSection.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritsTableViewCell
        cell?.setupCustomCell(indexCell: indexPath.row, data: restaurantSection[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension FavoritsTableViewController: HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ restaurants: [RestaurantData]) {
        DispatchQueue.main.async {
            self.restaurantSection = restaurants
            self.tableView.reloadData()
        }
    }
}

extension FavoritsTableViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
        }
    }
}


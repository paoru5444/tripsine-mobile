//
//  FavoritsTableViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit
import UIView_Shimmer


class FavoritsTableViewController: UITableViewController {
    
    let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    let mapViewController = MapViewController()
    let mapsViewModel = MapService()
    var restaurantSection: [RestaurantData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequestForMapView()
        tableView.dataSource = self
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
    }

    func updateHomeFromMaps(_ address: LocationResultData) {
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func makeRequestForMapView() {
        mapViewController.getAddressByCoordenates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailsViewController
        
        let funcionality = shouldUpdateStatus(data: restaurantSection)
        
        for section in restaurantSection {
            destinationVC.nameText = section.name ?? String()
            destinationVC.addressText = section.address ?? String()
            destinationVC.statusText = funcionality
            destinationVC.funcionalityText = "08:00 - 22:00"
            destinationVC.descriprionText = section.description ?? String()
            destinationVC.ratingText = section.rating ?? String()
            destinationVC.priceText = section.price ?? String()
            destinationVC.emailText = section.email ?? String()
            destinationVC.urlText = section.website ?? String()
            
            if let url = URL(string: section.photo?.image?.original?.url ?? "") {
                if let imageData = try? Data(contentsOf: url) {
                    destinationVC.iconImage = UIImage(data: imageData) ?? UIImage()
                }
            }
        }
  
    }

    private func shouldUpdateStatus(data: [RestaurantData]) -> String {
        for data in data {
            let isOpen = data.isOpen
            if isOpen {
                return "OPEN"
            } else {
                return "CLOSED"
            }
        }
        return String()
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritsTableViewCell {
            cell.setupCustomCell(indexCell: indexPath.row, data: restaurantSection[indexPath.row])
            return cell
        }
        return UITableViewCell()
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


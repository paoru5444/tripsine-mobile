//
//  FavoritsTableViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 07/06/22.
//

import UIKit

class FavoritsTableViewController: UITableViewController {
    
    let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    var restaurantSection: [RestaurantData] = []
    let mapViewController = MapViewController()
    let mapsViewModel = MapService()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeRequestForMapView()
        restaurantViewModel.delegate = self
        mapViewController.delegate = self
        self.setupUI()
        
        loadingIndicator.isAnimating = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.loadingIndicator.isAnimating = false
        }
    }

    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    func updateHomeFromMaps(_ address: LocationResultData) {
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = .white
        self.view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }
    
    private func makeRequestForMapView() {
        mapViewController.getAddressByCoordenates()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritsTableViewCell {
            cell.setupCustomCell(data: restaurantSection)
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


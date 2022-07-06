//
//  DetailsViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 29/05/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var funcionalityStatusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var reservButton: UIButton!
    
    let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    var restaurantSection: [RestaurantData] = []
    let mapViewController = MapViewController()
    let mapsViewModel = MapService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeRequestForMapView()
        restaurantViewModel.delegate = self
        mapViewController.delegate = self

//        loadingIndicator.isAnimating = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
//            self.loadingIndicator.isAnimating = false
//        }
    }

    @IBAction func didReservedButton(_ sender: Any) {
        guard let number = URL(string: "+1 415-775-8500") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    func updateHomeFromMaps(_ address: LocationResultData) {
        restaurantViewModel.makeRequestWithLocationId(locationId: address.location_id)
    }
    
    private func makeRequestForMapView() {
        mapViewController.getAddressByCoordenates()
    }
    
    private func setupView() {
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 8
        
        reservButton.layer.cornerRadius = 10
        
        statusLabel.layer.cornerRadius = 8
        statusLabel.layer.borderWidth = 1
        statusLabel.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    private func setupData(_ data: [RestaurantData]) {
        guard let rating = data.first?.rating else { return }
        
        titleLabel.text = data.first?.name
        addressLabel.text = data.first?.address
//        statusLabel.text = "\(shouldUpdateStatus(data: data))"
////        funcionalityStatusLabel: UILabel!
        descriptionLabel.text = data.first?.description
        ratingLabel.text = "/ \(rating)"
        priceLabel.text = data.first?.price
        emailLabel.text = data.first?.email
        urlLabel.text = data.first?.website
        
        if let url = URL(string: data.first?.photo?.image?.original?.url ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func shouldUpdateStatus(data: RestaurantData) -> String {
        let isOpen = data.isOpen
        if isOpen {
            return "OPEN"
        } else {
            return "CLOSED"
        }
    }
}

extension DetailsViewController: HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ restaurants: [RestaurantData]) {
        DispatchQueue.main.async {
            self.restaurantSection = restaurants
            self.setupData(self.restaurantSection)
        }
    }
}

extension DetailsViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
        }
    }
}

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
    }
    
    private func setupData(index: Int, data: [RestaurantData]) {
        guard let rating = data[index].rating,
              let title = data[index].name,
        let address = data[index].address,
        let descriptionn = data[index].description,
        let price = data[index].price,
        let email = data[index].email,
        let url = data[index].website else { return }
        
        titleLabel.text = title
        addressLabel.text = address
        descriptionLabel.text = descriptionn
        ratingLabel.text = "\(rating)"
        priceLabel.text = price
        emailLabel.text = email
        urlLabel.text = url
        
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
            self.setupData(index: 0, data: self.restaurantSection)
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

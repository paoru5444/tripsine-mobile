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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var reservButton: UIButton!
    
    let restaurantViewModel: HomeRestaurantViewModel = HomeRestaurantViewModel()
    let mapViewController = MapViewController()
    let mapsViewModel = MapService()
    
    var iconImage: UIImage = UIImage()
    var nameText: String = ""
    var addressText: String = ""
    var statusText: String = ""
    var descriprionText: String = ""
    var ratingText: String = ""
    var priceText: String = ""
    var emailText: String = ""
    var urlText: String = ""
    var isOpen: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewController.delegate = self
        
        setupView()
        makeRequestForMapView()
        setupData()
    }

    @IBAction func didReservedButton(_ sender: Any) {
        guard let number = URL(string: "tel://+1 415-775-8500") else { return }
        UIApplication.shared.open(number)
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
    
    private func setupData() {
        imageView.image = iconImage
        titleLabel.text = nameText
        addressLabel.text = addressText
        statusLabel.text = isOpen
        descriptionLabel.text = descriprionText
        ratingLabel.text = ratingText
        priceLabel.text = priceText
        emailLabel.text = emailText
        urlLabel.text = urlText
        imageView.image = iconImage
    }
}

extension DetailsViewController: MapViewControllerDataSource {
    func getInitialLocation(address: String) {
        mapsViewModel.fetchLocationIdBy(address: address) { resultData in
            self.restaurantViewModel.makeRequestWithLocationId(locationId: resultData.location_id)
        }
    }
}

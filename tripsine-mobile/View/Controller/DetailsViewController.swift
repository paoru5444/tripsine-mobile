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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestData()
    }

    @IBAction func didReservedButton(_ sender: Any) {
        print("move to web view")
    }
    
    private func requestData() {
        restaurantViewModel.makeRequest()
        restaurantViewModel.makeRequestWith(locationId: "São Paulo")
    }
    
    private func setupView() {
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 8
        
        reservButton.layer.cornerRadius = 10
        
        statusLabel.layer.cornerRadius = 8
        statusLabel.layer.borderWidth = 1
        statusLabel.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    private func setupData(_ data: RestaurantData) {
        titleLabel.text = data.name
        addressLabel.text = data.address
        statusLabel.text = "\(shouldUpdateStatus(data: data))"
//        funcionalityStatusLabel: UILabel!
        descriptionLabel.text = data.description
        ratingLabel.text = data.rating
        priceLabel.text = data.price
        emailLabel.text = data.email
        urlLabel.text = data.website
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
            self.setupData(self.restaurantSection[0])
            self.view.layoutIfNeeded()
        }
    }
}


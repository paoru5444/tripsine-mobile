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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCornerRadius()
    }

    @IBAction func didReservedButton(_ sender: Any) {
        print("move to web view")
    }
    
    private func setupCornerRadius() {
        priceLabel.layer.borderWidth = 2
        reservButton.layer.cornerRadius = 10
        statusLabel.layer.cornerRadius = 10
        statusLabel.layer.borderWidth = 2
        statusLabel.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
    }
}


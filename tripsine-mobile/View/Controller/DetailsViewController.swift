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
        setupView()
    }

    @IBAction func didReservedButton(_ sender: Any) {
        print("move to web view")
    }
    
    private func setupView() {
        priceLabel.layer.masksToBounds = true
        priceLabel.layer.cornerRadius = 8
        
        reservButton.layer.cornerRadius = 10
        
        statusLabel.layer.cornerRadius = 8
        statusLabel.layer.borderWidth = 1
        statusLabel.layer.borderColor = UIColor.systemGreen.cgColor
    }
}


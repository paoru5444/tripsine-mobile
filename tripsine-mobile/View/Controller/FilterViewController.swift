//
//  FilterViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 24/06/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var mealsButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var isOpenButton: UIButton!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCornerRadius()
    }
    
    @IBAction func didSendData(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    private func addCornerRadius() {
        ratingButton.layer.cornerRadius = 10
        mealsButton.layer.cornerRadius = 10
        categoryButton.layer.cornerRadius = 10
        isOpenButton.layer.cornerRadius = 10
        priceButton.layer.cornerRadius = 10
        filterButton.layer.cornerRadius = 10
        
        ratingButton.layer.borderWidth = 1
        mealsButton.layer.borderWidth = 1
        categoryButton.layer.borderWidth = 1
        isOpenButton.layer.borderWidth = 1
        priceButton.layer.borderWidth = 1
    }

    private func isClicked() {
        if ratingButton.isSelected {
            ratingButton.backgroundColor = .red
        }
    }

}

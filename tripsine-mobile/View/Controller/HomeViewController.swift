//
//  HomeViewController.swift
//  tripsine-mobile
//
//  Created by Bianca on 09/06/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var searchRestaurantTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        renderView()
    }
    
    private func renderView() {
        filterButton.layer.cornerRadius = 10
        renderImageTextField()
    }
    
    private func renderImageTextField() {
        searchRestaurantTextField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0,
                                                  y: 10,
                                                  width: 20,
                                                  height: 20))
        let image = UIImage(named: "search icon" )
        imageView.image = image
        searchRestaurantTextField.leftView = imageView
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryIdentifier", for: indexPath) as? CategoryCollectionViewCell
        else { return UICollectionViewCell() }
       
        if indexPath.row == 0 {
            setupLayerCell(cell: cell)
            cell.backgroundColor = .red
        } else {
            setupLayerCell(cell: cell)
        }
        return cell
    }
    
    private func setupLayerCell(cell: UICollectionViewCell) {
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.red.cgColor
    }
}

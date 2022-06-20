//
//  ProfileViewController.swift
//  tripsine-mobile
//
//  Created by Felipe Augusto on 6/8/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var aboutSquareIconImage: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var logoutSquareIconImage: UIImageView!
    
    @IBOutlet weak var profileRedCircleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutSquareIconImage.layer.shadowColor = UIColor.black.cgColor
        logoutSquareIconImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoutSquareIconImage.layer.shadowRadius = 5
        logoutSquareIconImage.layer.shadowOpacity = 0.1
        
        aboutSquareIconImage.layer.shadowColor = UIColor.black.cgColor
        aboutSquareIconImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        aboutSquareIconImage.layer.shadowRadius = 5
        aboutSquareIconImage.layer.shadowOpacity = 0.1
        
        
        editProfileButton.layer.shadowColor = UIColor.black.cgColor
        editProfileButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        editProfileButton.layer.shadowRadius = 5
        editProfileButton.layer.shadowOpacity = 0.1
        editProfileButton.layer.cornerRadius = 8
        
        // mark: Profile image
        setupProfileImage()
    }
    
    func setupProfileImage() {
        let viewRadius: CGFloat = profileRedCircleView.bounds.size.width / 2.0
        
        let imageRadius: CGFloat = profilePicImage.bounds.size.width / 2.0

//        profileRedCircleView.clipsToBounds = true
        profileRedCircleView.layer.masksToBounds = true
        profileRedCircleView.layer.cornerRadius = viewRadius
        profileRedCircleView.layer.borderWidth = 2
        profileRedCircleView.layer.borderColor = UIColor(red: 0.816, green: 0.067, blue: 0.063, alpha: 1).cgColor
        
//        profilePicImage.clipsToBounds = true
        profilePicImage.layer.masksToBounds = true
        profilePicImage.layer.cornerRadius = imageRadius
        
    }
    

}

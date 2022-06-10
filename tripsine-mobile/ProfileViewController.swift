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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.semanticContentAttribute = .forceRightToLeft
        
        logoutSquareIconImage.layer.shadowColor = UIColor.black.cgColor
        logoutSquareIconImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoutSquareIconImage.layer.shadowRadius = 5
        logoutSquareIconImage.layer.shadowOpacity = 0.1
        
        aboutSquareIconImage.layer.shadowColor = UIColor.black.cgColor
        aboutSquareIconImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        aboutSquareIconImage.layer.shadowRadius = 5
        aboutSquareIconImage.layer.shadowOpacity = 0.1
        
        aboutButton.semanticContentAttribute = .forceRightToLeft
        
        editProfileButton.layer.shadowColor = UIColor.black.cgColor
        editProfileButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        editProfileButton.layer.shadowRadius = 5
        editProfileButton.layer.shadowOpacity = 0.1
        editProfileButton.layer.cornerRadius = 10
        
        profilePicImage.layer.masksToBounds = true
        profilePicImage.layer.cornerRadius = profilePicImage.bounds.width / 2

    }
    

}

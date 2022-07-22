//
//  ProfileViewController.swift
//  tripsine-mobile
//
//  Created by Felipe Augusto on 6/8/22.
//

import UIKit
import FirebaseAuth

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
        setupProfileImage()
        renderView()
    }
    
    private func renderView() {
        editProfileButton.layer.shadowColor = UIColor.black.cgColor
        editProfileButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        editProfileButton.layer.shadowRadius = 5
        editProfileButton.layer.shadowOpacity = 0.1
        editProfileButton.layer.cornerRadius = 8
    }
    
    private func setupProfileImage() {
        let viewRadius: CGFloat = profileRedCircleView.bounds.size.width / 2.0
        let imageRadius: CGFloat = profilePicImage.bounds.size.width / 2.0

        profileRedCircleView.layer.masksToBounds = true
        profileRedCircleView.layer.cornerRadius = viewRadius
        profileRedCircleView.layer.borderWidth = 2
        profileRedCircleView.layer.borderColor = UIColor(red: 0.816, green: 0.067, blue: 0.063, alpha: 1).cgColor
        
        profilePicImage.layer.masksToBounds = true
        profilePicImage.layer.cornerRadius = imageRadius
    }
    
    @IBAction func showAlertView(_ sender: Any) {
       showSimpleAlert()
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        showSimpleAlert()
        
    }
    
    private func showSimpleAlert() {
        let alert = UIAlertController(
            title: "Sign out?",
            message: "Tem certeza que deseja sair do app?",
            preferredStyle: .alert
        )
        
        let actionCancel = UIAlertAction(title: "Cancelar", style: .default)
        let actionLogOut = UIAlertAction(title: "Sair", style: .destructive) { _ in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                
                DispatchQueue.main.async {
                    guard let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
                        
                    loginViewController.modalPresentationStyle = .fullScreen
                    self.present(loginViewController, animated: true)
                }
                
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
        }
        
        alert.addAction(actionCancel)
        alert.addAction(actionLogOut)
        
        present(alert, animated: true, completion: nil)
    }
    
}

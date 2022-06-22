//
//  LoginViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 19/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginUIButton: UIButton!
    @IBOutlet weak var registerUIButton: UIButton!
    @IBOutlet weak var googleUIButton: UIView!
    @IBOutlet weak var facebookUIButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
    }
    func setupLoginButton() {
        // mark: Login Button
        loginUIButton.layer.masksToBounds = true
        loginUIButton.layer.cornerRadius = 10
        
        // mark: Register Button
        registerUIButton.layer.masksToBounds = true
        registerUIButton.layer.cornerRadius = 10
        registerUIButton.layer.borderColor = UIColor(red: 0.816, green: 0.067, blue: 0.063, alpha: 1).cgColor
        registerUIButton.layer.borderWidth = 1
        
        // mark: Google Button
        googleUIButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        googleUIButton.layer.shadowOpacity = 1
        googleUIButton.layer.shadowRadius = 4
        googleUIButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        googleUIButton.layer.cornerRadius = 10
        
        // mark: Facebook Button
        facebookUIButton.layer.masksToBounds = true
        facebookUIButton.layer.cornerRadius = 10
    }
}

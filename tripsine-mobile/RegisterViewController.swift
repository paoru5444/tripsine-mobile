//
//  RegisterViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 10/06/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showLogin(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

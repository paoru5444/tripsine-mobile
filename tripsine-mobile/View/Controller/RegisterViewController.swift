//
//  RegisterViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 10/06/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setupTextField() {
        nameTextField.keyboardType = .asciiCapable
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
        
        telephoneTextField.keyboardType = .numberPad
        telephoneTextField.autocorrectionType = .no
        telephoneTextField.autocorrectionType = .no
        
        
    }
    
}

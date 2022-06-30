//
//  RegisterViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 10/06/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let viewModel = RegisterViewModel()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerProfileButton(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if viewModel.isValidEmail(email) == false {
            showAlert(title: "Email Inválido", message: "O email digitado não é válido")
        }
        
        if viewModel.isValidPassword(password) == false {
            showAlert(title: "Senha Inválida", message: "A senha digitada não é válida")
        }
        
        if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(title: "Confirmação de Senha", message: "A senha não é a mesma!")
        }
    }
    
    private func showAlert(title: String, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

//
//  RegisterViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 10/06/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setupTextField() {
        nameTextField.keyboardType = .asciiCapable
        nameTextField.autocorrectionType = .no
        nameTextField.autocapitalizationType = .none
    }
    
    
    @IBAction func registerAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        
        guard let password = passwordTextField.text else { return }
        
        guard let confirmPassword = confirmPasswordTextField.text else { return }
        
        let hasEmptyCredentials = email == "" || password == "" || confirmPassword == ""
            
        if (hasEmptyCredentials) {
            showEmptyDataAlert()
            return
        }
        
        if password != confirmPassword {
            showPasswordMissMatchAlert()
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                self.showWrongCredentialsAlert(message: error?.localizedDescription ?? "Preencha os dados novamente.")
                return
            }
            self.redirectToLoginScreen()
        }
    }
    
    func redirectToLoginScreen() {
        DispatchQueue.main.async {
            guard let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
                
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true)
        }
    }
    
    private func showEmptyDataAlert() {
        let alert = UIAlertController(
            title: "Dados cadastrais não preenchidos.",
            message: "Preencha todos os dados para fazer cdastro.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showWrongCredentialsAlert(message: String) {
        let alert = UIAlertController(
            title: "Erro no cadastro.",
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showPasswordMissMatchAlert() {
        let alert = UIAlertController(
            title: "Senhas não combinam.",
            message: "Digite senhas iguais para fazer o cadastro.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

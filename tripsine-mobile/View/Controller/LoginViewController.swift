//
//  LoginViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 19/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {
    @IBOutlet weak var loginUIButton: UIButton!
    @IBOutlet weak var registerUIButton: UIButton!
    
    
    @IBOutlet weak var facebookAuthOutlet: UIButton!
    @IBOutlet weak var googleAuthOutlet: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()

        let user = Auth.auth().currentUser
        
        if user != nil {
            user?.getIDTokenForcingRefresh(true)
            redirectToHomeScreen()
            return
        }
        
        if let token = AccessToken.current,
            !token.isExpired {
            redirectToHomeScreen()
            return
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    func redirectToHomeScreen() {
        DispatchQueue.main.async {
            guard let customUITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as? CustomUITabBarController else { return }
                
            customUITabBarController.modalPresentationStyle = .fullScreen
            self.present(customUITabBarController, animated: true)
        }
    }
    
    func setupLoginButton() {
        // mark: Login Button
        loginUIButton.layer.masksToBounds = true
        loginUIButton.layer.cornerRadius = 10
        
        // mark: Google Button
        applyShadownIn(button: googleAuthOutlet)
        
        
        // mark: Facebook Button
        facebookAuthOutlet.layer.masksToBounds = true
        facebookAuthOutlet.layer.cornerRadius = 10
    }
    
    func applyShadownIn(button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.cornerRadius = 10
    }
    
    @IBAction func googleAuthAction(_ sender: Any) {
        let config = GIDConfiguration(clientID: "830015598014-l2kk5jjl2ko9ovv8ol38t1fsoorrcq92.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            // ...
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
          )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                      if let error = error {
                          print(error)
                      }
                      // ...
                self.redirectToHomeScreen()
                return
            }
        }
    }
    
    @IBAction func facebookAuthAction(_ sender: Any) {
        print("login facebook")
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
                self.redirectToHomeScreen()
            }
        }
    }
    
    
    @IBAction func emailAuthAction(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if email != "" && password != "" {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                print("Logged In")
                if error != nil {
                    self?.showWrongCredentialsAlert()
                    return
                }
                self?.redirectToHomeScreen()
            }
        } else {
            showWrongCredentialsAlert()
        }
    }
    
    private func showWrongCredentialsAlert() {
        let alert = UIAlertController(
            title: "Email e/ou senha incorretos.",
            message: "Preencha os dados novamente para fazer login.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}

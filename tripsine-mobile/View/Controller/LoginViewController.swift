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

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextFild: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginUIButton: UIButton!
    @IBOutlet weak var registerUIButton: UIButton!
    @IBOutlet weak var googleUIButton: GIDSignInButton!
    @IBOutlet weak var facebookUIButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        let user = Auth.auth().currentUser
        
        if user != nil {
            user?.getIDTokenForcingRefresh(true)
            redirectToHomeScreen()
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
    
    @IBAction func performGoogleLoginAction(_ sender: Any) {
        getGoogleSetting()
    }
    func getGoogleSetting() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: "830015598014-l2kk5jjl2ko9ovv8ol38t1fsoorrcq92.apps.googleusercontent.com")

        // Start the sign in flow!
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
            firebaseAuth(credential)
        }
    }
    
    @IBAction func logInButtonAction(_ sender: Any) {
        guard let emailText = emailTextFild.text,
              let passwordText = passwordTextField.text else { return }
        
        isValidEmail(emailText)
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { dataResult, error in
            
            print(dataResult)
            print(error)
        }
    }
    
    func firebaseAuth(_ credencial: AuthCredential) {
        Auth.auth().signIn(with: credencial) { authResult, error in
            if let error = error {
                print(error)
            }
            // ...
            self.redirectToHomeScreen()
            return
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}

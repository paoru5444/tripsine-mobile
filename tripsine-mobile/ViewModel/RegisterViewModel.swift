//
//  RegisterViewModel.swift
//  tripsine-mobile
//
//  Created by Alex Pacheco on 29/06/22.
//

import Foundation

class RegisterViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$"
        
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)

        return passwordPred.evaluate(with: password)
    }
}

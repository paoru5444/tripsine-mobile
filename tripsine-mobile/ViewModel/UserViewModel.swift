//
//  UserViewModel.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 29/07/22.
//

import Foundation
import FirebaseAuth
import FBSDKCoreKit

class UserViewModel {
    func getUser() -> UserModel? {
        var user: UserModel? = nil
        
        Profile.loadCurrentProfile { profile, error in
            if error != nil { return }
            
            let imageUrl = profile?.imageURL(forMode: .normal, size: CGSize(width: 60, height: 60))?.absoluteString

            let obj = UserModel(
                name: profile?.name,
                email: "",
                image: imageUrl
            )
            user = obj
        }
        
        if let googleData = Auth.auth().currentUser {
            let obj = UserModel(
                name: googleData.displayName,
                email: googleData.email,
                image: googleData.photoURL?.absoluteString
            )
            user = obj
        }
        
        return user
    }
    
    func fetchUserProfile() -> UserModel? {
        let request = GraphRequest(graphPath:"me", parameters: ["fields": "email, name, picture"])
            
        var user: UserModel? = nil
            
            request.start {(connection, result, error) in
//                if error != nil { return }
//
//                guard let userData = result as? [String:AnyObject] else { return }
                
                user = UserModel(name: "Velosinho", email: "velosinho.tudao@gmail.com", image: "")
            }
        
        return user
    }
}

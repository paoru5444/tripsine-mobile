//
//  UserModel.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 29/07/22.
//

import Foundation

class UserModel {
    var name: String?
    var email: String?
    var image: Data?
    
    init(name: String?, email: String?, image: String?) {
        self.name = name
        self.email = email
        self.image = parseStringToURL(image)
    }
    
    func parseStringToURL(_ image: String?) -> Data? {
        if let url = URL(string: image ?? "") {
            if let imageData = try? Data(contentsOf: url) {
                return imageData
            }
        }
        return nil
    }
}

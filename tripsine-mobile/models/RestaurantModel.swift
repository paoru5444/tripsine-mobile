//
//  RestaurantsModel.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 29/05/22.
//

import Foundation

class RestaurantsModel {
    struct ImageValues: Codable {
        var width: String?
        var height: String?
        var url: String?
    }
    
    struct ImageSizes: Codable {
        var small: ImageValues?
        var thumbnail: ImageValues?
        var original: ImageValues?
        var large: ImageValues?
        var medium: ImageValues?
    }
    
    struct RestaurantImage: Codable {
        var images: ImageSizes?
    }
    
    struct Restaurant: Codable {
        let name: String?
        let location: String?
        let rating: String?
        let isClosed: Bool?
        let price: String?
        let photo: RestaurantImage?
        let address: String?
        let website: String?
        let email: String?
    }
 }

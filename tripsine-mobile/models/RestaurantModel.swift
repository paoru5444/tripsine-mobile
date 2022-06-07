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
    
    struct Filter: Codable {
        let filter_sections: [FilterSections]?
    }
    
    struct FilterSections: Codable {
        let label: String?
        let section_id: String?
        let filter_groups: [FilterGoups]?
    }
    
    struct FilterGoups: Codable {
        let type: String?
        let key: String?
        let tracking_key: String?
        let label: String?
        let options: [FilterGoupsOptions]?
    }
    
    struct FilterGoupsOptions: Codable {
        let label: String?
        let value: String?
        let selected: Bool?
        let count: String?
        let `default`: Bool?
        let single_select: Bool?
    }
 }

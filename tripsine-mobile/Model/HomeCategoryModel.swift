//
//  HomeCategoryModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

struct HomeCategoryModel: Codable {
    let data: [RestaurantData]
    let filters: SearchFilters
    
    enum CodingKeys: String, CodingKey {
        case data
        case filters = "filters_v2"
    }
}

struct SearchFilters: Codable {
    let filterSection: [FilterSection]
    
    enum CodingKeys: String, CodingKey {
        case filterSection = "filter_sections"
    }
}

struct FilterSection: Codable {
    let description: String
    let section: String
    
    enum CodingKeys: String, CodingKey {
        case description = "label"
        case section = "section_id"
    }
}

struct RestaurantData: Codable {
    let name: String?
    let address: String?
    let photo: PhotoData?
    let isOpen: Bool = true
    let price: String?
    let rating: String?
    let description: String?
    let website: String?
    let phone: String?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case name, photo, price,
             rating, description,
             website, phone, email
        case address = "location_string"
        case isOpen = "is_closed"
    }
}

struct PhotoData: Codable {
    let image: Images?
    
    enum CodingKeys: String, CodingKey {
        case image = "images"
    }
}

struct Images: Codable {
    let original: ImagesValues?
}

struct ImagesValues: Codable {
    let width: String?
    let height: String?
    let url: String?
}


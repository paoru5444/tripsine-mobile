//
//  HomeCategoryModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

struct HomeCategoryModel: Codable {
    let filters: SearchFilters
    
    enum CodingKeys: String, CodingKey {
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

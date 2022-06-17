//
//  HomeCategoryModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

struct HomeCategoryModel: Codable {
    let filters: SearchFilters
}

struct SearchFilters: Codable {
    let filterSection: FilterSection
}

struct FilterSection: Codable {
    let label: String?
    let sectionId: String?
}

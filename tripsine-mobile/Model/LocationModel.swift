//
//  LocationModel.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 16/06/22.
//

import Foundation

struct LocationResultData: Codable {
    let location_id: String
    let location_string: String
    
    init (location_id: String, location_string: String) {
        self.location_id = location_id
        self.location_string = location_string
    }
}

struct LocationData: Codable {
    let result_object: LocationResultData
}

struct LocationModel: Codable {
    let data: [LocationData]
}

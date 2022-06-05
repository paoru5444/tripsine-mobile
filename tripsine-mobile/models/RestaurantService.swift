//
//  RestaurantsService.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 29/05/22.
//

import Foundation

class RestaurantsService {
    struct Restaurants: Codable {
        let data: [RestaurantsModel.Restaurant]
    }
    
    func getRestaurants() -> Restaurants? {
        guard let url = Bundle.main.path(forResource: "restaurants", ofType: "json") else { return nil }
        guard let data = try? String(contentsOfFile: url).data(using: .utf8)! else { return nil }
        return parse(json: data)
    }
    
    private func parse(json: Data) -> Restaurants? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Restaurants.self, from: json)
    }
}

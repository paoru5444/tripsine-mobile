//
//  RestaurantCoreDataService.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 16/07/22.
//

import Foundation
import UIKit

class RestaurantCoreDataService {
    private let context = (UIApplication.shared.delegate as! RestaurantCoreData).persistentContainer.viewContext
    
    func setContext() {
        let appDelegate = (UIApplication.shared.delegate as! RestaurantCoreData)
        appDelegate.saveContext()
    }
    
    func setRestaurantData(
        restaurants: [RestaurantData]
    ) {
        let restaurant = Restaurant(context: context)
        
        do {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            let json = try jsonEncoder.encode(restaurants)
            let jsonString = String(data: json, encoding: .utf8)
            
            restaurant.restaurants = jsonString
            setContext()
        } catch {
            print("Parse array to string failed")
        }
        
    }
    
    func getLocationData() -> [RestaurantData]? {
        do {
            let response = try context.fetch(Restaurant.fetchRequest())
            guard let data = response.last?.restaurants else { return [] }
            let restaurantsData = data.data(using: .utf8)!
            let restaurants = try JSONDecoder().decode(HomeCategoryModel.self, from: restaurantsData)
            return restaurants.data
        } catch {
            print(error)
            return []
        }
    }
    
    func cleanLocationData(restaurant: Restaurant) {
        context.delete(restaurant)
    }
}

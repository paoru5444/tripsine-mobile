//
//  HomeRestaurantViewModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 20/06/22.
//

import Foundation

protocol HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ filter: [RestaurantData])
}

class HomeRestaurantViewModel {
    
    private var service: HomeRestaurantService
    private var restaurantModel = [RestaurantData]()
    var delegate: HomeRestaurantViewModelDelegate?
    
    init(service: HomeRestaurantService = .init()) {
        self.service = service
    }
    
    func makeRequest() {
        service.requestRestaurantService { data in
            self.restaurantModel = data
        }
    }
    
    func updateRestautantView(_ data: [RestaurantData]) {
        restaurantModel = data
        delegate?.updateRestaurant(restaurantModel)
    }
    
}

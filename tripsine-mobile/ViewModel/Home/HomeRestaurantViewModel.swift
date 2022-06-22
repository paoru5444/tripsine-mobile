//
//  HomeRestaurantViewModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 20/06/22.
//

import Foundation

protocol HomeRestaurantViewModelDelegate {
    func updateRestaurant(_ restaurants: [RestaurantData])
}

class HomeRestaurantViewModel {
    
    private var service: HomeRestaurantService
    private var restaurantModel = [RestaurantData]()
    var delegate: HomeRestaurantViewModelDelegate?
    
    init(service: HomeRestaurantService = .init()) {
        self.service = service
    }
    
    func makeRequestWith(locationId: String) {
        service.requestRestaurantService(locationId) { data in
            self.delegate?.updateRestaurant(data)
        }
    }
    
    func makeRequest() {
        let mapsViewModel = MapsViewModel()
        mapsViewModel.fetchLocationIdBy(address: "São Paulo") { address in
            self.service.requestRestaurantService(address.location_id) { data in
                self.delegate?.updateRestaurant(data)
            }
        }
    }
    
    func updateRestautantView(_ data: [RestaurantData]) {
        restaurantModel = data
        delegate?.updateRestaurant(restaurantModel)
    }
    
}

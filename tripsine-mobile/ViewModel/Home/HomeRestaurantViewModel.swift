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
    
    private var restaurantService: HomeRestaurantService
    private var mapService: MapService
    private var restaurantModel = [RestaurantData]()
    var delegate: HomeRestaurantViewModelDelegate?
    
    
    init(service: HomeRestaurantService = .init(), mapService: MapService = .init()) {
        self.restaurantService = service
        self.mapService = mapService
    }
    
    func makeRequestWithLocationId(locationId: String) {
        restaurantService.fetchRestaurantService(locationId) { data in
            self.delegate?.updateRestaurant(data)
        }
    }
    
    func makeRequest() {
        mapService.fetchLocationIdBy(address: "São Paulo") { address in
            self.restaurantService.fetchRestaurantService(address.location_id) { data in
                self.delegate?.updateRestaurant(data)
            }
        }
    }
    
    func updateRestautantView(_ data: [RestaurantData]) {
        restaurantModel = data
        delegate?.updateRestaurant(restaurantModel)
    }
    
}

//
//  HomeCategoryViewModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

protocol HomeCategoryViewModelDelegate {
    func updateCategory(_ filter: [FilterSection])
}

class HomeCategoryViewModel {
    
    private var restaurantService: HomeCategoryService
    private var mapService: MapService
    private var categoryModel = [FilterSection]()
    var delegate: HomeCategoryViewModelDelegate?
    
    init(service: HomeCategoryService = .init(), mapService: MapService = .init()) {
        self.restaurantService = service
        self.mapService = mapService
    }
    
    func makeRequest() {
        mapService.fetchLocationIdBy(address: "São Paulo") { address in
            self.restaurantService.fetchCategoryService(address.location_id) { filterSection in
                self.delegate?.updateCategory(filterSection)
            }
        }
    }
    
    func updateCategorySection(_ filter: [FilterSection]) {
        categoryModel = filter        
        delegate?.updateCategory(categoryModel)
    }
    
}

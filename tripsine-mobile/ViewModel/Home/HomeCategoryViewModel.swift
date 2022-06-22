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
    
    private var service: HomeCategoryService
    private var categoryModel = [FilterSection]()
    var delegate: HomeCategoryViewModelDelegate?
    
    init(service: HomeCategoryService = .init()) {
        self.service = service
    }
    
    func makeRequest() {
        let mapsViewModel = MapsViewModel()
        mapsViewModel.fetchLocationIdBy(address: "São Paulo") { address in
            self.service.requestCategoryService(address.location_id) { filterSection in
                self.delegate?.updateCategory(filterSection)
            }
        }
    }
    
    func updateCategorySection(_ filter: [FilterSection]) {
        categoryModel = filter        
        delegate?.updateCategory(categoryModel)
    }
    
}

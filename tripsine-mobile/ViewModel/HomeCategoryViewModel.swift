//
//  HomeCategoryViewModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryViewModel {
    
    private let service: HomeCategoryService
    
    init(service: HomeCategoryService = .init()) {
            self.service = service
    }
    
    func makeRequest() {
        service.requestCategoryService()
    }
    
}

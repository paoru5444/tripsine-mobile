//
//  HomeCategoryViewModel.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

protocol HomeCategoryViewModelDelegate {
    func updateCategory()
}

class HomeCategoryViewModel {
    
    private var service: HomeCategoryService
    
    private var model: HomeCategoryModel?
    var delegate: HomeCategoryViewModelDelegate?
    
    init(service: HomeCategoryService = .init()) {
        self.service = service
    }
    
    private func makeRequest() {
        service.requestCategoryService { categoryModel in
            self.model = categoryModel
//            self.updateCategoryText(categoryModel.filters.filterSection)
        }
    }

//    func updateCategoryText(_ model: [FilterSection]) -> [FilterSection] {
//        return [model]
//    }
    
}

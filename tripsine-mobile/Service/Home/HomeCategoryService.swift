//
//  HomeCategoryService.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryService: CommonService {
    
    func requestCategoryService(completion: @escaping ([FilterSection]) -> ()) {

        guard let url = component?.url else { return }
        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            let resume = try? JSONDecoder().decode(HomeCategoryModel.self, from: data)
            guard let resume = resume else { return }
            completion(resume.filters.filterSection)
        }
        dataTask.resume()
    }
}

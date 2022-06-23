//
//  HomeCategoryService.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryService: CommonService {
    
    func fetchCategoryService(_ locationId: String?, completion: @escaping ([FilterSection]) -> Void) {
        queryItems.append(URLQueryItem(name: "location_id", value: locationId ?? ""))
        component?.queryItems = queryItems
        
        guard let url = component?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            let response = try? JSONDecoder().decode(HomeCategoryModel.self, from: data)
            if let response = response {
                completion(response.filters.filterSection)
            } 
        }
        dataTask.resume()
    }
}

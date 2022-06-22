//
//  HomeCategoryService.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryService: CommonService {
    
    func requestCategoryService(_ locationId: String?, completion: @escaping ([FilterSection]) -> ()) {
        queryItems.append(URLQueryItem(name: "location_id", value: locationId ?? ""))
        
        guard let url = component?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        component?.queryItems = queryItems
        
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

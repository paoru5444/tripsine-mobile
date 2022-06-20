//
//  HomeCategoryService.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryService {
    
    func requestCategoryService(completion: @escaping ([FilterSection]) -> ()) {
        let headers = [
            "X-RapidAPI-Key": "9fd4fcfd26msh60b602655b093dap11fcc5jsnee05ddd96216",
            "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
        ]

        var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?")
        let session = URLSession.shared
        
        component?.queryItems = [
            URLQueryItem(name: "location_id", value: "293919"),
            URLQueryItem(name: "restaurant_tagcategory", value: "10591"),
            URLQueryItem(name: "restaurant_tagcategory_standalone", value: "10591"),
            URLQueryItem(name: "currency", value: "BRL"),
            URLQueryItem(name: "lunit", value: "km"),
            URLQueryItem(name: "limit", value: "30"),
            URLQueryItem(name: "open_now", value: "false"),
            URLQueryItem(name: "lang", value: "pt_BR")
        ]
        
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

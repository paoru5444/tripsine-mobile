//
//  HomeRestaurantService.swift
//  tripsine-mobile
//
//  Created by Bianca on 20/06/22.
//

import Foundation

class HomeRestaurantService: CommonService {
    
    func requestRestaurantService(completion: @escaping ([RestaurantData]) -> ()) {

        guard let url = component?.url else { return }
        var request = URLRequest(url: url)

        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            
            do {
                let resume = try? JSONDecoder().decode(HomeCategoryModel.self, from: data)
//                guard let resume = resume else { return }
                print(resume)
            } catch {
                print(error)
            }
//            completion(resume.data)
        }
        dataTask.resume()
    }
}

//
//  HomeCategoryService.swift
//  tripsine-mobile
//
//  Created by Bianca on 16/06/22.
//

import Foundation

class HomeCategoryService {
    
    func requestCategoryService() {
        let headers = [
            "X-RapidAPI-Key": "9fd4fcfd26msh60b602655b093dap11fcc5jsnee05ddd96216",
            "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?location_id=293919&restaurant_tagcategory=10591&restaurant_tagcategory_standalone=10591&currency=USD&lunit=km&limit=30&open_now=false&lang=en_US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            print(data)
        })

        dataTask.resume()
    }
}

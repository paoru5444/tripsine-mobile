//
//  CommonService.swift
//  tripsine-mobile
//
//  Created by Bianca on 18/06/22.
//

import Foundation

class CommonService {
    
    var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?")
    var searchComponent = URLComponents(string: "https://travel-advisor.p.rapidapi.com/locations/search")
    
    let headers = [
        "X-RapidAPI-Key": "9fd4fcfd26msh60b602655b093dap11fcc5jsnee05ddd96216",
        "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
    ]
    let session = URLSession.shared
    
    var queryItems = [
        URLQueryItem(name: "restaurant_tagcategory", value: "10591"),
        URLQueryItem(name: "restaurant_tagcategory_standalone", value: "10591"),
        URLQueryItem(name: "currency", value: "BRL"),
        URLQueryItem(name: "lunit", value: "km"),
        URLQueryItem(name: "limit", value: "10"),
        URLQueryItem(name: "open_now", value: "false"),
        URLQueryItem(name: "lang", value: "pt_BR")
    ]
    
    var searchQueryItems = [
        URLQueryItem(name: "limit" , value: "30"),
        URLQueryItem(name: "offset" , value: "0"),
        URLQueryItem(name: "units" , value: "km"),
        URLQueryItem(name: "location_id" , value: "1"),
    ]
}

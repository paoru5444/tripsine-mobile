//
//  CommonService.swift
//  tripsine-mobile
//
//  Created by Bianca on 18/06/22.
//

import Foundation

class CommonService {
    
    let headers = [
        "X-RapidAPI-Key": "d7319599e0msh0c3b7376be5c365p10b430jsn12eb2fe921c0",
        "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
    ]

    var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?")
    
    var searchComponent = URLComponents(string: "https://travel-advisor.p.rapidapi.com/locations/search")
    
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

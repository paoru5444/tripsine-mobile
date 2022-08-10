//
//  CommonService.swift
//  tripsine-mobile
//
//  Created by Bianca on 18/06/22.
//

import Foundation

class CommonService {
    // key atual:   0fe7961e27msh9c2d13079bef312p1727dajsn1f92af72844d
    // key reserva: 23668c2df4msh66de552977e7a8bp1fa194jsnfa8902564fb9
    let headers = [
        "X-RapidAPI-Key": "0fe7961e27msh9c2d13079bef312p1727dajsn1f92af72844d",
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
    
    var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?")
        
    var searchComponent = URLComponents(string: "https://travel-advisor.p.rapidapi.com/locations/search")
}

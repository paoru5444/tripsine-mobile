//
//  CommonService.swift
//  tripsine-mobile
//
//  Created by Bianca on 18/06/22.
//

import Foundation

class CommonService {
    
    let headers = [
        "X-RapidAPI-Key": "1c5fdcf35cmsh519a73eb778ea32p126345jsnbe1030df20ff",
        "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
    ]

    var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/restaurants/list?")
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
    
}

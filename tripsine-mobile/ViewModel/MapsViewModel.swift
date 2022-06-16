//
//  MapsViewModel.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 16/06/22.
//

import MapKit
import Foundation

protocol MapsViewModelDelegate {
    func covertionSuccessUpdateLocation(
        initialLocation: CLLocation,
        location: CLLocationCoordinate2D
    )
}

class MapsViewModel {
    
    var delegate: MapsViewModelDelegate?
    
    func fetchLocationIdBy(address: String, completion: @escaping () -> Void) {
        let headers = [
            "X-RapidAPI-Key": "406777944cmsh0dfe74177bed80ep150bf0jsn61afacef75fc",
            "X-RapidAPI-Host": "travel-advisor.p.rapidapi.com"
        ]
        
        var component = URLComponents(string: "https://travel-advisor.p.rapidapi.com/locations/search")
    
        
        let session = URLSession.shared
        
        component?.queryItems = [
            URLQueryItem(name: "query" , value: address),
            URLQueryItem(name: "limit" , value: "30"),
            URLQueryItem(name: "offset" , value: "0"),
            URLQueryItem(name: "units" , value: "km"),
            URLQueryItem(name: "location_id" , value: "1"),
        ]
        
        guard let url = component?.url else { return }
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            let location = try? decoder.decode(LocationModel.self, from: data)
            print(location?.data.first?.result_object)
        }
        
        dataTask.resume()
    }
    
    func convertAddressToCoordinate(address: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate
            else {
                return
            }
          
            let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            
            self.delegate?.covertionSuccessUpdateLocation(
                initialLocation: initialLocation,
                location: location
            )
        }
    }
}
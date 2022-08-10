//
//  MapService.swift
//  tripsine-mobile
//
//  Created by Bianca on 23/06/22.
//

import MapKit
import Foundation

protocol MapsViewModelDelegate {
    func covertionSuccessUpdateLocation(
        initialLocation: CLLocation,
        location: CLLocationCoordinate2D
    )
    func fetchLocationFailure(error: Error)
    func fetchLocationSuccess(location: LocationResultData)
    func alertMessageOnFailure(message: String)
}

class MapService: CommonService {
    
    var delegate: MapsViewModelDelegate?
    
    func fetchLocationIdBy(address: String, completion: @escaping (LocationResultData) -> Void) {
        searchQueryItems.append(URLQueryItem(name: "query", value:  address))
        searchComponent?.queryItems = searchQueryItems
        
        guard let url = searchComponent?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        
        let dataTask = session.dataTask(with: request) { data, _, error in
            if let error = error {
                self.delegate?.fetchLocationFailure(error: error)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let location = try? decoder.decode(LocationModel.self, from: data)
                if let resultData: LocationResultData = location?.data.first?.result_object {
                    self.delegate?.fetchLocationSuccess(location: resultData)
                    completion(resultData)
                } else {
                    self.delegate?.alertMessageOnFailure(message: "Erro ao buscar o endereço, tente novamente")
                }
                return
            }
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
                self.delegate?.alertMessageOnFailure(message: "Não conseguimos encontrar \(address), tente um novo endereço.")
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

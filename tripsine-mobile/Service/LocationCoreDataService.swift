//
//  LocationCoreDataService.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 09/07/22.
//

import Foundation
import UIKit

class LocationCoreDataService {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func setContext() {
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.saveContext()
    }
    
    func setLocationData(
        location_id: String,
        location_string: String
    ) {
        let location = Location(context: context)
        location.location_id = location_id
        location.location_string = location_string
        setContext()
    }
    
    func setCoordinateData(
        latitude: Double,
        longitude: Double
    ) {
        let location = Location(context: context)
        location.latitude = latitude
        location.longitude = longitude
        setContext()
    }
    
    func getLocationData() -> [Location] {
        do {
            return try context.fetch(Location.fetchRequest())
        } catch {
            print(error)
        }
        
        return []
    }
    
    func cleanLocationData(location: Location) {
        context.delete(location)
    }
    
    func hasCoreDataAddress() -> Bool {
        let coreDataLocation = getLocationData().first
        return coreDataLocation?.location_id != "" && coreDataLocation?.location_string != ""
    }
}

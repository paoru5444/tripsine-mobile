//
//  MapViewController.swift
//  tripsine-mobile
//
//  Created by Paulo Roberto on 05/06/22.
//

import MapKit
import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var UIMapKit: MKMapView!
    
    @IBOutlet weak var searchLocationTextField: UITextField!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func searchLocationButton(_ sender: Any) {
        guard let address = searchLocationTextField.text else { return }
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate
            else {
                return
            }
            
            let initialLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            self.UIMapKit.centerToLocation(initialLocation)
            self.showArtwork(lat: location.latitude, lng: location.longitude)
        }
        
    }
    
    func showArtwork(lat: Double, lng: Double) {
        let artwork = Artwork(
          title: "Você está aqui",
          locationName: "",
          discipline: "",
          coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng))
        
        UIMapKit.addAnnotation(artwork)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let initialLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        UIMapKit.centerToLocation(initialLocation)
        showArtwork(lat: locValue.latitude, lng: locValue.longitude)
    }
}

extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}

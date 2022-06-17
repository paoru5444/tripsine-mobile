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
    
    var locationSelected: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    let mapsViewModel: MapsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapsViewModel.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func confirmLocationButton(_ sender: Any) {
        guard let address = searchLocationTextField.text else { return }
        
        let getAddressAlert = UIAlertController(
            title: "Você está procurando por: \(address)",
            message: "Tem certeza que deseja buscar o endereço selecionado?",
            preferredStyle: .alert
        )
        
        let actionDefault = UIAlertAction(title: "Claro!!", style: .default) { _ in
            self.mapsViewModel.fetchLocationIdBy(address: address) {
                print("something")
            }
        }
        
        let actionCancel = UIAlertAction(title: "Tenho não", style: .destructive) { _ in
            self.searchLocationTextField.text = ""
            self.searchLocationTextField.updateFocusIfNeeded()
        }
        
        getAddressAlert.addAction(actionDefault)
        getAddressAlert.addAction(actionCancel)
        
        present(getAddressAlert, animated: true)
    }
    
    @IBAction func searchLocationButton(_ sender: Any) {
        guard let address = searchLocationTextField.text else { return }
            
        mapsViewModel.convertAddressToCoordinate(address: address)
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

extension MapViewController: MapsViewModelDelegate {
    func covertionSuccessUpdateLocation(initialLocation: CLLocation, location: CLLocationCoordinate2D) {
        locationSelected = location
        self.UIMapKit.centerToLocation(initialLocation)
        self.showArtwork(lat: location.latitude, lng: location.longitude)
    }
}



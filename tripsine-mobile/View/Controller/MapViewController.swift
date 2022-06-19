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
    
    @IBOutlet weak var confirmLocationButton: UIButton!
    
    @IBOutlet weak var searchLocationButton: UIButton!
    
    let locationManager = CLLocationManager()
    
    var selectedLocation: LocationResultData?

    let mapsViewModel: MapsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapsViewModel.delegate = self
        searchLocationTextField.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        selectedLocation = LocationResultData(location_id: "", location_string: "")
        
        confirmLocationButton.isEnabled = false
        searchLocationButton.isEnabled = false
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
                DispatchQueue.main.async {
                    guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as? HomeViewController else { return }
                        secondViewController.modalPresentationStyle = .fullScreen
                        self.present(secondViewController, animated: true)
                }
            }
        }
        
        let actionCancel = UIAlertAction(title: "Tenho não", style: .destructive) { _ in
            self.setTextInputFocus()
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
    
    func errorAlert(message: String) {
        let alert = UIAlertController(title: "Ops", message: message, preferredStyle: .alert)
        
        let actionDefault = UIAlertAction(title: "Buscar outro endereço", style: .default) { _ in
            self.setTextInputFocus()
        }
        
        alert.addAction(actionDefault)
        
        present(alert, animated: true)
    }
    
    func setTextInputFocus() {
        searchLocationTextField.text = ""
        searchLocationTextField.updateFocusIfNeeded()
        confirmLocationButton.isEnabled = false
        searchLocationButton.isEnabled = false
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
        self.UIMapKit.centerToLocation(initialLocation)
        self.showArtwork(lat: location.latitude, lng: location.longitude)
        confirmLocationButton.isEnabled = true
    }
    
    func fetchLocationSuccess(location: LocationResultData) {
        selectedLocation = location
    }
    
    func fetchLocationFailure(error: Error) {
        errorAlert(message: error.localizedDescription)
        print(error.localizedDescription)
    }
    
    func alertMessageOnFailure(message: String) {
        DispatchQueue.main.async {
            self.errorAlert(message: message)
        }
    }
}

extension MapViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberOfChars = range.lowerBound
        if numberOfChars <= 0 {
            confirmLocationButton.isEnabled = false
            searchLocationButton.isEnabled = false
            
        } else {
            searchLocationButton.isEnabled = true
        }
        return true
    }
}


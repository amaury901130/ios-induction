//
//  MainViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MainViewController: UIViewController {
  
  var viewModel: MainViewModel!
  var locationManager: CLLocationManager?
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initLocationManager()
  }
  
  private func initLocationManager() {
    locationManager = CLLocationManager()
    
    if let manager = locationManager {
      manager.delegate = self
      manager.desiredAccuracy = kCLLocationAccuracyBest
    }
  }
}

extension MainViewController: CLLocationManagerDelegate {
  
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    switch status {
    case .authorizedWhenInUse:
      manager.startUpdatingLocation()
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    default:
      break
    }
  }
  
  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    if let location = locations.last {
      let center = CLLocationCoordinate2D(
        latitude: location.coordinate.latitude,
        longitude: location.coordinate.longitude
      )
      
      let region = MKCoordinateRegion(
        center: center,
        span: MKCoordinateSpan(
          latitudeDelta: 0.02,
          longitudeDelta: 0.02
      ))
      
      //todo: add custom pin
      let annotation = MKPointAnnotation()
      annotation.coordinate = location.coordinate
      annotation.title = "You are here"
      
      mapView.setRegion(region, animated: true)
      mapView.addAnnotation(annotation)
      manager.stopUpdatingLocation()
    }
  }
}

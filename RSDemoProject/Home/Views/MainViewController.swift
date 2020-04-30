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
  
  private func displayCurrentLocation(_ location: CLLocation) {
    mapView.center(location)
    mapView.addAnnotation(location: location)
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
      displayCurrentLocation(location)
      manager.stopUpdatingLocation()
    }
  }
}

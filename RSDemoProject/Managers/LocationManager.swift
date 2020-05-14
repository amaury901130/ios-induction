//
//  LocationManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/30/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
  
  typealias LocationUpdateListener = (CLLocation) -> Void
  
  static let shared = LocationManager()
  
  var currentLocation: CLLocation!
  var locationUpdateListener: LocationUpdateListener?
  var manager: CLLocationManager = CLLocationManager()
  
  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  public func requestCurrentLocation(listener: @escaping LocationUpdateListener) {
    locationUpdateListener = listener
    verifyAuthorization()
  }
  
  func verifyAuthorization() {
    manager.requestWhenInUseAuthorization()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(
    _ manager: CLLocationManager,
    didChangeAuthorization status: CLAuthorizationStatus
  ) {
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
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
    guard
      let location = locations.last,
      let listener = locationUpdateListener
    else { return }
    
    currentLocation = location
    listener(location)
    manager.stopUpdatingLocation()
  }
}

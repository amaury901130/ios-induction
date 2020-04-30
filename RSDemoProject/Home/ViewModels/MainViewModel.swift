//
//  MainViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainViewModelDelegate: class {
  func didUpdateLocation(_ location: CLLocation)
}

class MainViewModel {
  
  var currentLocation: CLLocation?
  var delegate: MainViewModelDelegate?
  var locationManager = LocationManager.shared

  func requestCurrentLocation() {
    locationManager.requestCurrentLocation(listener: updateCurrentLocation(_:))
  }
  
  private func updateCurrentLocation(_ location: CLLocation) {
    currentLocation = location
    delegate?.didUpdateLocation(location)
  }
}

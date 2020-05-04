//
//  MainViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
  
  var viewModel: MainViewModel!
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel = MainViewModel()
    initMap()
  }
  
  private func initMap() {
    viewModel.requestCurrentLocation()
  }
  
  private func addCurrentLocation(_ location: CLLocation) {
    mapView.addAnnotation(location: location)
  }
}

extension MainViewController: MainViewModelDelegate {
  func didUpdateLocation(_ location: CLLocation) {
    addCurrentLocation(location)
  }
}

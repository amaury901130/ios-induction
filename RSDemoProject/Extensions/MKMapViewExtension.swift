//
//  MKMapViewExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
  
  func center(_ location: CLLocation, region: Double = 0.02, animate: Bool = true) {
    let center = CLLocationCoordinate2D(
      latitude: location.coordinate.latitude,
      longitude: location.coordinate.longitude
    )
    
    let region = MKCoordinateRegion(
      center: center,
      span: MKCoordinateSpan(
        latitudeDelta: region,
        longitudeDelta: region
    ))
    
    setRegion(region, animated: animate)
  }
}

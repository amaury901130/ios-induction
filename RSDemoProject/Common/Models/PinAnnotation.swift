//
//  PinAnnotation.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/12/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import MapKit

class PinAnnotation: MKPointAnnotation {

  var pinView: ImageAnnotationView!
  
  var pinType: AnnotationType!
  
  init(_ location: CLLocation, pinType: AnnotationType = .selectedLocation) {
    super.init()
    self.pinType = pinType
    self.coordinate = location.coordinate
    pinView = ImageAnnotationView(
      annotation: self,
      pinType: pinType
    )
  }
}

enum AnnotationType {
  case selectedLocation
  case target(target: Target)
  
  // the pinImageName is a local image or the topic icon url
  var pinImageName: String {
    switch self {
    case .selectedLocation:
      return "selectedLocation"
    case .target(let target):
      return target.topic?.icon ?? "selectedLocation"
    }
  }

  var identifier: String {
    switch self {

    case .selectedLocation:
      return "selectedLocation"
    case .target:
      return "target"
    }
  }
}

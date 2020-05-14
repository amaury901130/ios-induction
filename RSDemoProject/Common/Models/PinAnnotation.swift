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
  case selectedLocationRatio
  case topic(topic: Topic)
  
  // the pinImageName is a local image or the topic icon url
  var pinImageName: String {
    switch self {
    case .selectedLocation:
      return "selectedLocation"
    case .selectedLocationRatio:
      return "selectedLocationRatio"
    case .topic(let topic):
      return topic.icon.absoluteString
    }
  }
  
  var identifier: String {
    switch self {

    case .selectedLocation:
      return "selectedLocation"
    case .selectedLocationRatio:
      return "selectedLocationRatio"
    case .topic( _):
      return "topic"
    }
  }
}

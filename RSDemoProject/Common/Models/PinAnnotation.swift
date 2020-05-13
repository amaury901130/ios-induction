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
  var pinType: AnnotationType!
}

enum AnnotationType {
  case selectedLocation
  case selectedLocationRatio
  case topic(topic: Topic)
  
  var pinImage: String {
    switch self {
    case .selectedLocation:
      return "selectedLocation"
    case .selectedLocationRatio:
      return "selectedLocationRatio"
    case .topic(let topic):
      return topic.icon
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

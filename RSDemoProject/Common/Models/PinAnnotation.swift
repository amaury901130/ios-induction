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
  var type: AnnotationType!
}

enum AnnotationType: String {
  case selectedLocation
  
  case selectedLocationRatio
  
  case chirstmas
  
  case pokemonGo
  
  case football
  
  case travel
  
  case politics
  
  case art
  
  case dating
  
  case music
  
  case movie
  
  case serie
  
  case food
  
  var pinImage: UIImage {
    switch self {
    // TODO add all images
    case .selectedLocation:
      return "selectedLocation".image
    case .selectedLocationRatio:
      return "selectedLocationRatio".image
    case .chirstmas:
      return "selectedLocation".image
    case .pokemonGo:
      return "selectedLocation".image
    case .football:
      return "selectedLocation".image
    case .travel:
      return "selectedLocation".image
    case .politics:
      return "selectedLocation".image
    case .art:
      return "selectedLocation".image
    case .dating:
      return "selectedLocation".image
    case .music:
      return "selectedLocation".image
    case .movie:
      return "selectedLocation".image
    case .serie:
      return "selectedLocation".image
    case .food:
      return "selectedLocation".image
    }
  }
}

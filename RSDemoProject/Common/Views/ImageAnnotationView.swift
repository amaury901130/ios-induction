//
//  ImageAnnotationView.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/13/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import MapKit
import Kingfisher

class ImageAnnotationView: MKAnnotationView {
  private var imageView: UIImageView!
  private let iconSize = 40
  private let iconPosition = -20
  var pinType: AnnotationType!
  var overlay: MKCircle?
  
  init(
    annotation: MKAnnotation?,
    pinType: AnnotationType
  ) {
    super.init(annotation: annotation, reuseIdentifier: pinType.identifier)
    
    self.pinType = pinType
    let customImage = pinType.pinImageName
    
    switch pinType {
    case .target:
      if customImage.isUrlFormatted() {
        imageView = UIImageView(
          frame: CGRect(
            x: iconPosition,
            y: iconPosition,
            width: iconSize,
            height: iconSize
          )
        )
        imageView.kf.setImage(
          with: URL(string: customImage),
          placeholder: R.image.selectedLocation()
        )
        addSubview(imageView)
      } else {
        image = customImage.image
      }
    default:
      image = customImage.image
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

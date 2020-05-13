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
  
  init(annotation: MKAnnotation?, reuseIdentifier: String?, customImage: String) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
    if customImage.isUrlFormatted() {
      // todo: change the image size
      imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
      imageView.kf.setImage(with: URL(string: customImage))
      addSubview(imageView)
    } else {
      image = customImage.image
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

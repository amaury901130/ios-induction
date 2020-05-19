//
//  UIButtonExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/21/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit
import Kingfisher

extension UIButton {
  func setEnable(_ enable: Bool = true) {
    isEnabled = enable
    alpha = isEnabled ? 1 : 0.5
  }
  
  func addSpacing(kernValue: Double) {
    var attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
    
    if let currentAttrString = attributedTitle(for: .normal) {
      attributedString = NSMutableAttributedString(attributedString: currentAttrString)
    }
    
    setTitle(.none, for: .normal)
    
    attributedString.addAttribute(
      .kern,
      value: kernValue,
      range: NSRange(
        location: 0,
        length: attributedString.length
    ))
    
    setAttributedTitle(attributedString, for: .normal)
  }
  
  func setIcon(url: String?) {
    guard let icon = url, let iconURL = URL(string: icon) else {
      return
    }
    
    let defaultImage = "targetPointer".image
    let iconImageSize: CGFloat = 28
    let verticalInset: CGFloat = 12
    let horizontalInset = (frame.size.width - iconImageSize) / 2
    
    imageEdgeInsets = UIEdgeInsets(
      top: verticalInset,
      left: horizontalInset - 32,
      bottom: verticalInset,
      right: horizontalInset + 32)
    
    kf.setImage(
      with: iconURL,
      for: .normal,
      placeholder: defaultImage
    )
  }
}

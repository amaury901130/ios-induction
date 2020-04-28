//
//  UIButtonExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/21/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

extension UIButton {
  func setEnable(_ enable: Bool = true) {
    isEnabled = enable
    alpha = isEnabled ? 1 : 0.5
  }
  
  func addSpacing(kernValue: Double) {
    let attributedString: NSMutableAttributedString!
    if let currentAttrString = attributedTitle(for: .normal) {
      attributedString = NSMutableAttributedString(attributedString: currentAttrString)
    } else {
      attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
      setTitle(.none, for: .normal)
    }
    
    attributedString.addAttribute(
      .kern,
      value: kernValue,
      range: NSRange(
        location: 0,
        length: attributedString.length))
    
    setAttributedTitle(attributedString, for: .normal)
  }
}

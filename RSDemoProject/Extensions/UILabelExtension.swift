//
//  UILabelExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/20/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

extension UILabel {
  func addSpacing(kernValue: Double) {
    if let labelText = text, !labelText.isEmpty {
      let attributedString = NSMutableAttributedString(string: labelText)
      attributedString.addAttribute(.kern,
                                    value: kernValue,
                                    range: NSRange(location: 0, length: attributedString.length))
      attributedText = attributedString
    }
  }
}

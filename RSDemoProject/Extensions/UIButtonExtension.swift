//
//  UIButtonExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/21/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

extension UIButton {
  func shouldEnable(enable: Bool = true) {
    isEnabled = enable
    alpha = isEnabled ? 1 : 0.5
  }
}

//
//  TextField.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/20/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class TextField: UITextField {

  var padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)

  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
    
  }

  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
}


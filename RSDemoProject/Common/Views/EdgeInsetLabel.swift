//
//  Label.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/22/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//
import UIKit

@IBDesignable
class EdgeInsetLabel: UILabel {
  
  private var textSpacing: Double = 0 {
    didSet { addSpacing(kernValue: textSpacing) }
  }
  
  var textInsets = UIEdgeInsets.zero {
    didSet { invalidateIntrinsicContentSize() }
  }
  
  override func textRect(
    forBounds bounds: CGRect,
    limitedToNumberOfLines numberOfLines: Int
  ) -> CGRect {
    let insetRect = bounds.inset(by: textInsets)
    let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    let invertedInsets =
      UIEdgeInsets(
        top: -textInsets.top,
        left: -textInsets.left,
        bottom: -textInsets.bottom,
        right: -textInsets.right
    )
    
    return textRect.inset(by: invertedInsets)
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
  }
}

extension EdgeInsetLabel {
  @IBInspectable
  var leftTextInset: CGFloat {
    set { textInsets.left = newValue }
    get { textInsets.left }
  }
  
  @IBInspectable
  var rightTextInset: CGFloat {
    set { textInsets.right = newValue }
    get { textInsets.right }
  }
  
  @IBInspectable
  var topTextInset: CGFloat {
    set { textInsets.top = newValue }
    get { textInsets.top }
  }
  
  @IBInspectable
  var bottomTextInset: CGFloat {
    set { textInsets.bottom = newValue }
    get { textInsets.bottom }
  }
  
  @IBInspectable
  var letterSpacing: Double {
    set { textSpacing = newValue }
    get { textSpacing }
  }
}

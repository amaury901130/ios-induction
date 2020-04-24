//
//  CustomTextView.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CustomFormField: UIStackView {
  var label = UILabel()
  var textView = TextField()
  var errorLabel = UILabel()
  
  let textFieldSise: Float = 16
  let placeHolderSize: Float = 14
  let labelSize: Float = 11
  let labelLetterSpacing = 1.5
  
  var validationPattern: String = ""
  var errorText: String = ""
  var mandatory: Bool = false
  var mandatoryText: String = ""
  
  @IBInspectable var placeholder: String = "" {
    didSet {
      textView.placeholder = placeholder
      textView.font = UIFont(
        name: App.textFieldFont,
        size: CGFloat(placeholder.isEmpty ? textFieldSise : placeHolderSize)
      )
    }
  }
  
  @IBInspectable var labelText: String = "" {
    didSet {
      label.text = labelText
      label.addSpacing(kernValue: labelLetterSpacing)
    }
  }
  
  open func showError(_ show: Bool = true) {
    errorLabel.text = show ? errorText : ""
    errorLabel.addSpacing(kernValue: labelLetterSpacing)
    textView.layer.borderColor = show ? App.errorColor : UIColor.black.cgColor
  }
  
  open func setKeyboardType(type: UIKeyboardType) {
    textView.keyboardType = type
  }
  
  open func isSecure(isSecure: Bool = true) {
    textView.isSecureTextEntry = isSecure
  }
  
  private func showMandatoryError() {
    errorLabel.text = mandatoryText
    errorLabel.addSpacing(kernValue: labelLetterSpacing)
    textView.layer.borderColor = App.errorColor
  }
  
  open func validate() -> Bool {
    guard validationPattern.isEmpty else {
      if let text = textView.text {
        guard text.isEmpty else {
          let valid = text.validate(validationPattern)
          showError(!valid)
          return valid
        }
      }
      
      return validateMandatory()
    }
    
    return validateMandatory()
  }
  
  private func validateMandatory() -> Bool {
    if mandatory && textView.text!.isEmpty {
      showMandatoryError()
      return false
    }
    
    showError(false)
    return true
  }
  
  open func text() -> String {
    return textView.text ?? ""
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    initCustomView()
  }

  required init(coder: NSCoder) {
    super.init(coder: coder)
    initCustomView()
  }
  
  private func initCustomView() {
    self.axis = .vertical
    self.distribution = .equalCentering
    self.spacing = 4
    
    addLabel()
    addTextView()
    addErrorLabel()
  }
  
  private func addLabel() {
    label.textColor = .black
    label.font = UIFont(name: App.textFieldFont, size: CGFloat(labelSize))
    label.textAlignment = .center
    self.addArrangedSubview(label)
  }
  
  private func addTextView() {
    textView.font = UIFont(name: App.textFieldFont, size: CGFloat(textFieldSise))
    textView.layer.borderColor = UIColor.black.cgColor
    textView.layer.borderWidth = 1
    self.addArrangedSubview(textView)
  }
  
  private func addErrorLabel() {
    errorLabel.textColor = UIColor.red
    errorLabel.textAlignment = .center
    errorLabel.font = UIFont(name: App.textFieldFont, size: CGFloat(labelSize))
    self.addArrangedSubview(errorLabel)
    errorText = ""
  }
}

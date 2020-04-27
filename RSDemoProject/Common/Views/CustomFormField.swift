//
//  CustomTextView.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CustomFormField: UIStackView, UITextFieldDelegate {
  lazy var label = UILabel()
  lazy var textView = TextField()
  lazy var errorLabel = UILabel()
  
  let textFieldSize: Float = 16
  let placeHolderSize: Float = 14
  let labelSize: Float = 11
  let labelLetterSpacing = 1.5
  let itemSpacing: CGFloat = 4
  
  var validationPattern = ""
  var errorText = ""
  var mandatory = false
  var mandatoryText = ""
  var text: String {
    textView.text ?? ""
  }
  
  @IBInspectable var placeholder: String = "" {
    didSet {
      textView.placeholder = placeholder
      textView.font = UIFont(
        name: App.textFieldFont,
        size: CGFloat(placeholder.isEmpty ? textFieldSize : placeHolderSize)
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
    if !validationPattern.isEmpty && !text.isEmpty {
      let valid = text.validate(validationPattern)
      showError(!valid)
      return valid
    }
    
    return validateMandatory()
  }
  
  private func validateMandatory() -> Bool {
    if mandatory && textView.text?.isEmpty ?? true {
      showMandatoryError()
      return false
    }
    
    showError(false)
    return true
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
    axis = .vertical
    distribution = .equalCentering
    spacing = itemSpacing
    
    addLabel()
    addTextView()
    addErrorLabel()
  }
  
  private func addLabel() {
    label.textColor = .black
    label.font = UIFont(name: App.textFieldFont, size: CGFloat(labelSize))
    label.textAlignment = .center
    addArrangedSubview(label)
  }
  
  private func addTextView() {
    textView.font = UIFont(name: App.textFieldFont, size: CGFloat(textFieldSize))
    textView.layer.borderColor = UIColor.black.cgColor
    textView.layer.borderWidth = 1
    addArrangedSubview(textView)
  }
  
  private func addErrorLabel() {
    errorLabel.textColor = UIColor.red
    errorLabel.textAlignment = .center
    errorLabel.font = UIFont(name: App.textFieldFont, size: CGFloat(labelSize))
    addArrangedSubview(errorLabel)
    errorText = ""
  }
}

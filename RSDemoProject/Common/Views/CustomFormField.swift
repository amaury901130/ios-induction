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
  var textView: UITextField!
  var errorLabel = UILabel()
  
  let textFieldSise: Float = 16
  let placeHolderSize: Float = 14
  let labelSize: Float = 11
  let labelLetterSpacing = 1.5

  @IBInspectable var placeholder: String = "" {
    didSet {
      if let textViewField = textView {
        textViewField.placeholder = placeholder
        textViewField.font = UIFont(
          name: App.textFieldFont,
          size: CGFloat(placeholder.isEmpty ? textFieldSise : placeHolderSize)
        )
      }
    }
  }
  
  @IBInspectable var text: String = "" {
    didSet {
      if let textViewField = textView {
        textViewField.text = text
      }
    }
  }
  
  @IBInspectable var labelText: String = "" {
    didSet {
      label.text = labelText
      label.addSpacing(kernValue: labelLetterSpacing)
    }
  }
  
  @IBInspectable var errorText: String = "" {
    didSet {
      errorLabel.text = errorText
      errorLabel.addSpacing(kernValue: labelLetterSpacing)
      if let txtView = textView {
        txtView.layer.borderColor = errorText.isEmpty ? UIColor.black.cgColor : App.errorColor
        txtView.layer.borderWidth = 1
      }
    }
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
    self.distribution = .fill
    self.spacing = 2
    
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
    textView = TextField()
    textView.font = UIFont(name: App.textFieldFont, size: CGFloat(textFieldSise))
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

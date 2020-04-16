//
//  CustomTextView.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/16/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class CustomTextView : UIView {
    var label = UILabel()
    var textView: PlaceholderTextView!
    var errorLabel = UILabel()
    var containerView = UIStackView()
    
    @IBInspectable var placeholder: String = "" {
      didSet {
        if let textViewField = textView {
            textViewField.placeholder = placeholder
            textViewField.font = UIFont(name: "GillSans",
                                        size: placeholder.isEmpty ? 16 : 14)
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
      }
    }
    
    @IBInspectable var errorText: String = "" {
      didSet {
        errorLabel.text = errorText
        if let txtView = textView {
            txtView.layer.borderColor =
                errorText.isEmpty ? UIColor.black.cgColor :
                UIColor(red: 0.896, green: 0.177, blue: 0.177, alpha:1).cgColor
            txtView.layer.borderWidth = 1
        }
      }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initCustomView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCustomView()
    }
    
    private func initCustomView() {
        containerView.axis = .vertical
        containerView.distribution = .fill
        containerView.spacing = 4
        containerView.frame = CGRect(x: 0, y: 0, width: 180, height: 68)
        self.addSubview(containerView)
        
        addLabel()
        addTextView()
        addErrorLabel()
    }
    
    private func addLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 180, height: 100)
        label.textColor = UIColor.black
        label.font = label.font.withSize(11)
        label.textAlignment = .center
        containerView.addArrangedSubview(label)
    }
    
    private func addTextView() {
        textView = PlaceholderTextView(frame: CGRect(x: 0, y: 0, width: 180, height: 64))
        textView.font = UIFont(name: "GillSans", size: 16)
        textView.textContainer.maximumNumberOfLines = 1
        textView.layoutManager.textContainerChangedGeometry(textView.textContainer)
        containerView.addArrangedSubview(textView)
    }
    
    private func addErrorLabel() {
        errorLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 100)
        errorLabel.textColor = UIColor.red
        errorLabel.textAlignment = .center
        label.font = label.font.withSize(11)
        containerView.addArrangedSubview(errorLabel)
        errorText = ""
    }
}

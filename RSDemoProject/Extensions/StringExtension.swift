//
//  StringExtension.swift
//  RSDemoProject
//
//  Created by Juan Pablo Mazza on 9/9/16.
//  Copyright © 2016 Rootstrap. All rights reserved.
//

import Foundation

extension String {
  var isAlphanumericWithNoSpaces: Bool {
    let alphaNumSet = CharacterSet(
      charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    )
    return rangeOfCharacter(from: alphaNumSet.inverted) == nil
  }
  
  var hasPunctuationCharacters: Bool {
    return rangeOfCharacter(from: CharacterSet.punctuationCharacters) != nil
  }
  
  var hasNumbers: Bool {
    return rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil
  }
  
  var localized: String {
    return self.localize()
  }
    
  func localize(comment: String = "") -> String {
    return NSLocalizedString(self, comment: comment)
  }
  
  var validFilename: String {
    guard !isEmpty else { return "emptyFilename" }
    return addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "emptyFilename"
  }
  
  //Regex fulfill RFC 5322 Internet Message format
  func isEmailFormatted() -> Bool {
    return validate(Validations.emailPattern)
  }
  
  func validate(_ pattern: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return predicate.evaluate(with: self)
  }
}

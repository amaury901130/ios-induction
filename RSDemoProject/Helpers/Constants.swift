//
//  Constants.swift
//  RSDemoProject
//
//  Created by German Lopez on 3/29/16.
//  Copyright © 2016 Rootstrap. All rights reserved.
//

import Foundation
import UIKit
//Add global constants here

struct App {
  static let domain = Bundle.main.bundleIdentifier ?? ""
  
  static func error(
    domain: ErrorDomain = .generic, code: Int? = nil,
    localizedDescription: String = ""
  ) -> NSError {
    return NSError(domain: App.domain + "." + domain.rawValue,
                   code: code ?? 0,
                   userInfo: [NSLocalizedDescriptionKey: localizedDescription])
  }

  static let yellowColor = UIColor(red: 0.937, green: 0.776, blue: 0.22, alpha: 1).cgColor
  static let blueColor = UIColor(red: 0.184, green: 0.737, blue: 0.969, alpha: 1).cgColor
  static let errorColor = UIColor(red: 0.896, green: 0.177, blue: 0.177, alpha:1).cgColor
  
  static let textFieldFont = "OpenSans-Regular"
}

enum ErrorDomain: String {
  case generic = "GenericError"
  case parsing = "ParsingError"
}

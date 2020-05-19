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

  static let textFieldFont = "OpenSans-Regular"
}

enum ErrorDomain: String {
  case generic = "GenericError"
  case parsing = "ParsingError"
}

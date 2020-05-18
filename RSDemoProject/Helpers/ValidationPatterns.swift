//
//  ValidationPatterns.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Validations {
  // swiftlint:disable line_length
  static let emailPattern = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
  // swiftlint:enable line_length
  static let passwordPattern = "[A-Z0-9a-z._%+-]{6,}"
  static let areaPattern = "[2-9][0-9]{2}|1000"
  static let urlPattern = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
}

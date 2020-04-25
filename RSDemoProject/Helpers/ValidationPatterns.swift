//
//  ValidationPatterns.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 4/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct Validations {
  static let emailPattern = "[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(\\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?\\.)+[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?"
  static let passwordPattern = "[A-Z0-9a-z._%+-]{6,}"
}

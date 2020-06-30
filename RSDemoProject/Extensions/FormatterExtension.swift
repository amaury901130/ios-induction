//
//  DateExtension.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/30/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "h:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    return formatter
  }()
}

extension Date {
  func string(using formatter: DateFormatter) -> String {
    formatter.string(from: self)
  }
}

extension String {
  func date(using formatter: DateFormatter) -> Date? {
    formatter.date(from: self)
  }
}

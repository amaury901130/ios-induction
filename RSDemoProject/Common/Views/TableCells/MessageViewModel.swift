//
//  MessageViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/30/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class MessageViewModel {
  var message: Message
  static let formatter: DateFormatter {
    let format = DateFormatter()
    
    format.locale = Locale(identifier: "en_US_POSIX")
    format.dateFormat = "h:mm a"
    format.amSymbol = "AM"
    format.pmSymbol = "PM"
    
    return format
  }
  
  init(_ message: Message) {
    self.message = message
  }
  
  var content: String {
    message.content
  }
  
  var time: String {
    return MessageViewModel.formatter.string(from: message.date)
  }
  
  var isMyMessage: Bool {
    (message.user?.id ?? -2) == (UserDataManager.currentUser?.id ?? -1)
  }
}

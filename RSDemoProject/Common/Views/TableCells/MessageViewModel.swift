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
  let formatter = DateFormatter()
  
  init(_ message: Message) {
    self.message = message
    setUpDateFormat()
  }
  
  private func setUpDateFormat() {
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "h:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
  }
  
  var content: String {
    message.content
  }
  
  var time: String {
    return formatter.string(from: message.date)
  }
  
  var isMyMessage: Bool {
    (message.user?.id ?? -2) == (UserDataManager.currentUser?.id ?? -1)
  }
}

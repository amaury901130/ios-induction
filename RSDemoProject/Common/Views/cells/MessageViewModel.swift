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
  
  init(_ message: Message) {
    self.message = message
  }
  
  var content: String! {
    message.content
  }
  
  var time: String! {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "h:mm a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"

    return formatter.string(from: message.date)
  }
  
  var isMyMessage: Bool {
    message.user.id == (UserDataManager.currentUser?.id ?? -1)
  }
}

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
  
  var content: String {
    message.content
  }
  
  var time: String {
    return message.date.string(using: DateFormatter.shortDateFormatter)
  }
  
  var isMyMessage: Bool {
    (message.user?.id ?? -2) == (UserDataManager.currentUser?.id ?? -1)
  }
}

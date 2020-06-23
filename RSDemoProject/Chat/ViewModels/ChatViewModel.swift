//
//  ChatViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum ChatState {
  case chatMessagesLoaded
  case messageSended
  case none
}

protocol ChatViewModelDelegate: class {
  func didUpdateState()
  func didUpdateNetworkState()
}

class ChatViewModel {
  
  init(_ conversation: Conversation) {
    self.conversation = conversation
  }
  
  var conversation: Conversation!
  var messages: [Message] = []
  var page = 1
  var webSocketManager = WSS.shared
  weak var delegate: ChatViewModelDelegate?
  
  var topicIconURL: URL? {
    URL(string: conversation.topicIcon)
  }
  
  var userName: String {
    conversation.user?.fullName ?? ""
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateNetworkState()
    }
  }
  
  var state: ChatState = .none {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  func connect() {
    webSocketManager.connect()
  }
  
  func disconnect() {
    webSocketManager.disconnect()
  }
  
  func sendMessage(message: String) {
    webSocketManager.send(
      text: message,
      conversation: conversation,
      completion: { [weak self] in
        self?.state = .messageSended
      }
    )
  }

  func loadMessages() {
    networkState = .loading
    ConversationService.shared.getMessages(
      conversationId: conversation.id,
      page: page,
      success: { [weak self] newMessages in
        self?.page += 1
        self?.messages.append(contentsOf: newMessages)
        self?.state = .chatMessagesLoaded
        self?.networkState = .idle
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
    })
  }
}

extension ChatViewModel: WSSDelegate {
  func onConnected() {
    //TODO
  }
  
  func onDisconnected(_ reason: String?) {
    //TODO
  }
  
  func onConnectionError(_ reason: String) {
    networkState = .error(reason)
  }

  func onText(_ text: String) {
    //TODO
  }
}

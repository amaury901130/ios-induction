//
//  ChatViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum ChatState {
  case messagesLoaded
  case messageSent
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
  
  private var conversation: Conversation!
  var messages: [Message] = []
  private var page = 1
  private var webSocketManager = WebSocketManager.shared
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
  
  var messagesCount: Int {
    messages.count
  }
  
  func getMessage(at index: Int) -> Message? {
    guard index < messagesCount else {
      return nil
    }
    
    return messages[index]
  }
  
  func sendMessage(message: String) {
    webSocketManager.send(
      text: message,
      conversation: conversation,
      completion: { [weak self] in
        self?.state = .messageSent
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
        self?.state = .messagesLoaded
        self?.networkState = .idle
      },
      failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
    })
  }
}

extension ChatViewModel: WebSocketManagerDelegate {
  func socketDidConnect() {
    //TODO
  }
  
  func socketDidDisconnect(_ reason: String?) {
    //TODO
  }
  
  func socketDidError(_ reason: String) {
    networkState = .error(reason)
  }
  
  func onMessageReceived(_ text: String) {
    //TODO
  }
}

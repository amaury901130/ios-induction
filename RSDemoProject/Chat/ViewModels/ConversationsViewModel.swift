//
//  ConversationsViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/19/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import RealmSwift

protocol ConversationsViewModelDelegate: class {
  func didUpdateState()
  func didUpdateNetworkState()
}

enum ConversationsState {
  case conversationsLoaded
  case conversationSelected
}

class ConversationsViewModel {
  var conversations: Results<Conversation>!
  var selectedConversation: Conversation?
  weak var delegate: ConversationsViewModelDelegate?
  
  var state: ConversationsState! {
    didSet{
      delegate?.didUpdateState()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet{
      delegate?.didUpdateNetworkState()
    }
  }
  
  var countConversations: Int {
    conversations?.count ?? 0
  }
  
  func getConversation(at index: Int) -> Conversation {
    conversations[index]
  }
  
  func selectConversation(at index: Int) {
    selectedConversation = conversations[index]
    state = .conversationSelected
  }
  
  func loadConversations() {
    conversations = DBManager.sharedInstance.appDB?.objects(Conversation.self)
  }
}

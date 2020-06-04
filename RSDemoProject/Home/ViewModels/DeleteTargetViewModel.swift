//
//  DeleteTargetViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/22/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum DeleteTargetState {
  case targetLoaded
  case targetDeleted
}

protocol DeleteTargetDelegate: class {
  func didUpdateDeleteTargetState()
  func didUpdateState()
}

class DeleteTargetViewModel {
  var target: Target!
  
  init(target: Target) {
    self.target = target
  }
  
  var delegate: DeleteTargetDelegate? {
    didSet {
      state = .targetLoaded
    }
  }
  
  var state: DeleteTargetState! {
    didSet {
      delegate?.didUpdateDeleteTargetState()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var formattedArea: String {
    "\(target.radius) m"
  }
  
  var targetDescription: String {
    target.title
  }
  
  var targetTopic: Topic? {
    target.topic
  }
}

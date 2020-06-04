//
//  DeleteTargetViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/22/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum DeleteTargetConfirmationState {
  case targetLoaded
  case targetDeleted
  case none
}

protocol DeleteTargetConfirmationDelegate: class {
  func didUpdateDeleteTargetState()
  func didUpdateState()
}

class DeleteTargetConfirmationViewModel {
  var target: Target!
  
  init(_ target: Target) {
    self.target = target
  }
  
  var delegate: DeleteTargetConfirmationDelegate? {
    didSet {
      state = .targetLoaded
    }
  }
  
  var state: DeleteTargetConfirmationState = .none {
    didSet {
      delegate?.didUpdateDeleteTargetState()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var targetDescription: String {
    target.title
  }
  
  var targetIcon: URL? {
    URL(string: target.topic?.icon ?? "")
  }
  
  func deleteTarget() {
    networkState = .loading
    TargetService.shared.deleteTarget(
      target: target,
      success: { [weak self] in
        self?.networkState = .idle
        self?.state = .targetDeleted
      }, failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      }
    )
  }
}

//
//  UpdatePasswordViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/2/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

protocol UpdatePasswordViewModelDelegate: class {
  func didUpdateState()
  func didUpdatePasswordState()
}

enum UpdatePasswordState {
  case paswwordUpdated
  case newPasswordError
}

class UpdatePasswordViewModel {
  
  var currentPassword: String!
  var newPassword: String!
  var repeatedNewPassword: String!
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var state: UpdatePasswordState? {
    didSet {
      delegate?.didUpdatePasswordState()
    }
  }
  
  weak var delegate: UpdatePasswordViewModelDelegate?
  
  func newRepeatedPasswordIsValid() -> Bool {
    guard
      let newPass = newPassword,
      let repeatedNewPass = repeatedNewPassword,
      newPass == repeatedNewPass
    else {
      state = .newPasswordError
      return false
    }
    
    return true
  }
  
  func updatePassword() {
    networkState = .loading
    
    UserService.sharedInstance.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword, { [weak self] in
        self?.networkState = .idle
        self?.state = .paswwordUpdated
      }, failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
    })
  }
}

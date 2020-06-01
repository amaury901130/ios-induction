//
//  EditProfileViewModel.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

enum EditProfileState {
  case profileUpdated
  case profileLoggedOut
}

protocol EditProfileViewModelDelegate: class {
  func didUpdateState()
  func didUpdateProfileState()
}

class EditProfileViewModel {
  
  var userName: String?
  var userEmail: String?
  
  weak var delegate: EditProfileViewModelDelegate? {
    didSet {
      userName = currentUser?.username
      userEmail = currentUser?.email
    }
  }
  
  var currentUser: User? {
    UserDataManager.currentUser
  }

  var state: EditProfileState? {
    didSet {
      delegate?.didUpdateProfileState()
    }
  }
  
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  func logOut() {
    networkState = .loading
    
    UserService.sharedInstance.logout({ [weak self] in
      self?.networkState = .idle
      self?.state = .profileLoggedOut
    }, failure: { [weak self] error in
      self?.networkState = .error(error.localizedDescription)
    })
  }
  
  func updateProfile() {
    //TODO: call update profile
  }
}

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
  
  var userName: String!
  var userEmail: String!
  var userUpdateImage: Data?
  
  var userImageURL: URL? {
    URL(string: currentUser?.avatar?.url ?? "")
  }
  
  weak var delegate: EditProfileViewModelDelegate? {
    didSet {
      guard let user = currentUser else {
        state = .profileLoggedOut
        return
      }

      userName = user.username
      userEmail = user.email
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
    guard let userId = currentUser?.id else {
      state = .profileLoggedOut
      return
    }
    
    networkState = .loading

    UserService.sharedInstance.update(
      id: userId,
      name: userName,
      email: userEmail,
      avatar: userUpdateImage,
      success: { [weak self] user in
        UserDataManager.currentUser = user
        self?.networkState = .idle
        self?.state = .profileUpdated
      }, failure: { [weak self] error in
        self?.networkState = .error(error.localizedDescription)
      })
  }
}

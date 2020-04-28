//
//  SignUpViewModel.swift
//  RSDemoProject
//
//  Created by German on 8/21/18.
//  Copyright © 2018 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

protocol SignUpViewModelDelegate: class {
  func didUpdateSignUpState()
  func didUpdateState()
}

enum SignUpViewModelState: Equatable {
  case signedUp
}

class SignUpViewModelWithEmail {
  var networkState: ViewModelState = .idle {
    didSet {
      delegate?.didUpdateState()
    }
  }
  
  var state: SignUpViewModelState? {
    didSet {
      delegate?.didUpdateSignUpState()
    }
  }
  
  weak var delegate: SignUpViewModelDelegate?
  
  var email = ""
  var name = ""
  var password = ""
  var passwordConfirmation = ""
  
  var hasValidData: Bool {
    email.isEmailFormatted() && !password.isEmpty && password == passwordConfirmation
  }
  
  func signup(name: String, email: String, password: String) {
    networkState = .loading
    UserService.sharedInstance.signup(
      email, name: name, password: password,
      success: { [weak self] in
        guard let self = self else { return }
        AnalyticsManager.shared.identifyUser(with: self.email)
        AnalyticsManager.shared.log(event: Event.registerSuccess(email: self.email))
        self.state = .signedUp
      },
      failure: { [weak self] error in
        if let apiError = error as? APIError {
          self?.networkState = .error(apiError.firstError ?? "") // show the first error
        } else {
          self?.networkState = .error(error.localizedDescription)
        }
    })
  }
}

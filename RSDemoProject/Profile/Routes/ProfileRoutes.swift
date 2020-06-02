//
//  ProfileRoutes.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/29/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum ProfileRoutes: Route {
  case editProfile
  case updatePassword
  
  var screen: UIViewController {
    switch self {
    case .editProfile:
      guard let editProfile = R.storyboard.main.editProfileViewController() else {
        return UIViewController()
      }
      
      editProfile.viewModel = EditProfileViewModel()
      return editProfile
    case .updatePassword:
      guard let updatePassword = R.storyboard.main.updatePasswordViewController() else {
        return UIViewController()
      }

      updatePassword.viewModel = UpdatePasswordViewModel()
      return updatePassword
    }
  }
}

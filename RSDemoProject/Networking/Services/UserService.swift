//
//  UserService.swift
//  RSDemoProject
//
//  Created by Mauricio Cousillas on 6/4/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum UserServiceError: Error {
  case noResponse
  
  var localizedDescription: String {
    String(describing: self)
  }
}

class UserService: BaseApiService<UserResource> {
  static let sharedInstance = UserService()
  
  func login(_ email: String,
             password: String,
             success: @escaping () -> Void,
             failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: .login(email, password),
            at: "data",
            onSuccess: { [weak self] (result: User, response) -> Void in
              guard let headers = response.response?.allHeaderFields else {
                failure(UserServiceError.noResponse)
                return
              }
              self?.saveUserSession(user: result, headers: headers)
              success()
      }, onFailure: { error, _ in
        failure(error)
    })
  }
  
  func signup(_ email: String,
              name: String,
              password: String,
              success: @escaping () -> Void,
              failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: .signup(email, name, password),
            onSuccess: { [weak self] (result: User, response) -> Void in
              guard let headers = response.response?.allHeaderFields else {
                failure(UserServiceError.noResponse)
                return
              }
              self?.saveUserSession(user: result, headers: headers)
              success()
      }, onFailure: { error, _ in
        failure(error)
    })
  }
  
  func getMyProfile(
    _ success: @escaping (_ user: User) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: .profile,
            at: "user",
            onSuccess: { (result: User, _) -> Void in
              success(result)
    },
            onFailure: { error, _ in
              failure(error)
    })
  }
  
  func loginWithFacebook(
    token: String,
    success: @escaping () -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: .fbLogin(token),
            at: "data",
            onSuccess: { [weak self] (result: User, response) -> Void in
              guard let headers = response.response?.allHeaderFields else {
                failure(UserServiceError.noResponse)
                return
              }
              self?.saveUserSession(user: result, headers: headers)
              success()
      },
            onFailure: { error, _ in
              failure(error)
    })
  }
  
  func saveUserSession(
    user: User,
    headers: [AnyHashable: Any]
  ) {
    UserDataManager.currentUser = user
    if let headers = headers as? [String: Any] {
      SessionManager.currentSession = Session(headers: headers)
    }
  }
  
  func logout(
    _ success: @escaping () -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(for: UserResource.logout,
            onSuccess: { _ in
              UserDataManager.deleteUser()
              SessionManager.deleteSession()
              success()
    }, onFailure: { error, _ in
      failure(error)
    })
  }
  
  func update(
    id: Int,
    name: String,
    email: String,
    avatar: Data?,
    success: @escaping (_ user: User) -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: UserResource.update(id, name, email, avatar),
      onSuccess: { (result: User, _) -> Void in success(result) },
      onFailure: { error, _ in failure(error) }
    )
  }
  
  func updatePassword(
    currentPassword: String,
    newPassword: String,
    success: @escaping () -> Void,
    failure: @escaping (_ error: Error) -> Void
  ) {
    request(
      for: UserResource.updatePassword(currentPassword, newPassword),
      onSuccess: { _ in success() },
      onFailure: { error, _ in failure(error) }
    )
  }
}

//
//  UserResource.swift
//  RSDemoProject
//
//  Created by Mauricio Cousillas on 6/4/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum UserResource: TargetType {
  
  case login(String, String)
  case signup(String, String, String)
  case profile
  case fbLogin(String)
  case logout
  
  var path: String {
    let authBasePath = "/users"
    let userBasePath = "/user"
    switch self {
    case .login:
      return "\(authBasePath)/sign_in"
    case .signup:
      return authBasePath
    case .profile:
      return "\(userBasePath)/profile"
    case .fbLogin:
      return "\(authBasePath)/facebook"
    case .logout:
      return "\(authBasePath)/sign_out"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .signup, .login, .fbLogin:
      return .post
    case .profile:
      return .get
    case .logout:
      return .delete
    }
  }
  
  var headers: [String: String]? {
    getHeaders()
  }
  
  var task: Task {
    switch self {
    case .login(let email, let password):
      let parameters = getLoginParams(email: email, password: password)
      return requestParameters(parameters: parameters)
    case .signup(
      let email,
      let name,
      let password):
      let parameters = getSignUpParams(
        email: email,
        name: name,
        password: password)
      return requestParameters(parameters: parameters)
    case .fbLogin(let token):
      let parameters = [
        "access_token": token
      ]
      return requestParameters(parameters: parameters)
    default:
      return .requestPlain
    }
  }
  
  private func getLoginParams(email: String, password: String) -> [String: Any] {
    [
      "user": [
        "email": email,
        "password": password
      ]
    ]
  }
  
  private func getSignUpParams(
    email: String, name: String, password: String
  ) -> [String: Any] {
    [
      "user": [
        "email": email,
        "username": name,
        "password": password,
        "password_confirmation": password
      ]
    ]
  }
  
  private func getSignUpMultipartParams(
    email: String, name: String, password: String
  ) -> [String: Any] {
    [
      "email": email,
      "username": name,
      "password": password,
      "password_confirmation": password
    ]
  }
}

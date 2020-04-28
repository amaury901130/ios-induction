//
//  User.swift
//  RSDemoProject
//
//  Created by Rootstrap on 1/18/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import Foundation

struct User: Codable {
  var id: Int
  var username: String?
  var email: String?
  var provider: String
  var uid: String
  var allowPasswordChange: Bool? = false
  var firstName: String
  var lastName: String
  var gender: String?
  var pushToken: String?
  var avatar: Image?

  private enum CodingKeys: String, CodingKey {
    case id
    case username
    case provider
    case uid
    case lastName = "last_name"
    case firstName = "first_name"
    case gender
    case email
    case avatar
    case allowPasswordChange = "allow_password_change"
    case pushToken = "push_token"
  }
}

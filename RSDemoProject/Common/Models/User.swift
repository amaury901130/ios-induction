//
//  User.swift
//  RSDemoProject
//
//  Created by Rootstrap on 1/18/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object, Codable {
  
  @objc dynamic var id: Int
  @objc dynamic var username: String?
  @objc dynamic var email: String?
  @objc dynamic var provider: String?
  @objc dynamic var uid: String?
  @objc dynamic var firstName: String?
  @objc dynamic var lastName: String?
  @objc dynamic var fullName: String?
  @objc dynamic var gender: String?
  @objc dynamic var pushToken: String?
  @objc dynamic var avatar: Image?

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
    case fullName = "full_name"
    case pushToken = "push_token"
  }
  
  override class func primaryKey() -> String? {
    return "id"
  }
}

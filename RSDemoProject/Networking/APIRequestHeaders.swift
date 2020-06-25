//
//  APIClient.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/25/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

struct APIRequestHeaders {
  static var baseHeaders: [String: String] =
    [
      HTTPHeader.accept.rawValue: "application/json",
      HTTPHeader.contentType.rawValue: "application/json"
    ]

  static var sessionHeaders: [String: String]? {
    if let session = SessionManager.currentSession {
      return Self.baseHeaders + [
        HTTPHeader.uid.rawValue: session.uid ?? "",
        HTTPHeader.client.rawValue: session.client ?? "",
        HTTPHeader.token.rawValue: session.accessToken ?? ""
      ]
    }
    return Self.baseHeaders
  }
}

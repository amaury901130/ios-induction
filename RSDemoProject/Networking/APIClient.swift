//
//  APIClient.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/25/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation

class APIClient {
  static private var baseHeaders: [String: String] {
    return [
      HTTPHeader.accept.rawValue: "application/json",
      HTTPHeader.contentType.rawValue: "application/json"
    ]
  }

  static public func getHeaders() -> [String: String]? {
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

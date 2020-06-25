//
//  WebSocketManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Starscream

class WebSocketManager: WebSocketDelegate {
  static let shared = WebSocketManager()
  
  var url: URL? {
    let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "WebSocket URL")
    return URL(string: baseUrlString as? String ?? "")
  }
  
  private var baseHeaders: [String: String] {
    return [
      HTTPHeader.accept.rawValue: "application/json",
      HTTPHeader.contentType.rawValue: "application/json"
    ]
  }
  
  var headers: [String: String] {
    if let session = SessionManager.currentSession {
      return baseHeaders + [
        HTTPHeader.uid.rawValue: session.uid ?? "",
        HTTPHeader.client.rawValue: session.client ?? "",
        HTTPHeader.token.rawValue: session.accessToken ?? ""
      ]
    }
    return baseHeaders
  }
  
  var webSocket: WebSocket!
  weak var delegate: WebSocketManagerDelegate?
  
  func connect() {
    guard let wsUrl = url else {
      delegate?.socketDidError("wss_error_url".localized)
      return
    }
    
    if webSocket == nil {
      webSocket = WebSocket(request: URLRequest(url: wsUrl))
      webSocket.delegate = self
    }
    
    webSocket.request.allHTTPHeaderFields = APIClient.getHeaders()
    webSocket.connect()
  }
  
  func disconnect() {
    webSocket.disconnect()
  }
  
  func send(text: String, conversation: Conversation, completion: (() -> Void)?) {
    guard let message = getFormattedMessage(content: text, conversationId: conversation.id) else {
      delegate?.socketDidError("wss_error_bad_format".localized)
      return
    }
    
    webSocket.write(string: message, completion: completion)
  }
  
  private func getFormattedMessage(
    content: String,
    conversationId: Int
  ) -> String? {
    let message: [String: String] = [
      "action": "send_message",
      "content": content,
      "match_conversation_id": "\(conversationId)"
    ]

    guard let data = try? JSONEncoder().encode(message) else {
      return nil
    }
    
    return String(data: data, encoding: String.Encoding.utf8)
  }
  
  func didReceive(event: WebSocketEvent, client: WebSocket) {
    switch event {
    case .connected:
      delegate?.socketDidConnect()
    case .disconnected(let reason, _):
      delegate?.socketDidDisconnect(reason)
    case .text(let string):
      delegate?.onMessageReceived(string)
    default: break
    }
  }
}

protocol WebSocketManagerDelegate: class {
  func socketDidConnect()
  func socketDidDisconnect(_ reason: String?)
  func socketDidError(_ reason: String)
  func onMessageReceived(_ text: String)
}

//
//  WebSocketManager.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import Foundation
import Starscream

class WSS: WebSocketDelegate {
  static let shared = WSS()
  
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
  
  var ws: WebSocket!
  weak var delegate: WSSDelegate?
  
  func connect() {
    guard let wsUrl = url else {
      delegate?.onConnectionError("wss_error_url".localized)
      return
    }
    
    if ws == nil {
      ws = WebSocket(request: URLRequest(url: wsUrl))
      ws.delegate = self
    }
    
    ws.request.allHTTPHeaderFields = headers
    ws.connect()
  }
  
  func disconnect() {
    ws.disconnect()
  }
  
  func send(text: String, conversation: Conversation, completion: (() -> Void)?) {
    guard let message = getFormattedMessage(content: text, conversationId: conversation.id) else {
      delegate?.onConnectionError("wss_error_bad_format".localized)
      return
    }
    
    ws.write(string: message, completion: completion)
  }
  
  private func getFormattedMessage(
    content: String,
    conversationId: Int
  ) -> String? {
    let message: [String : String] = [
      "action": "send_message",
      "content": content,
      "match_conversation_id": "\(conversationId)"
    ]
    
    let jsonData = try? JSONEncoder().encode(message)
    
    guard let data = jsonData else {
      return nil
    }
    
    return String(data: data, encoding: String.Encoding.utf8)
  }
  
  func didReceive(event: WebSocketEvent, client: WebSocket) {
    switch event {
    case .connected:
      delegate?.onConnected()
    case .disconnected(let reason, _):
      delegate?.onDisconnected(reason)
    case .text(let string):
      delegate?.onText(string)
    default: break
    }
  }
}

protocol WSSDelegate {
  func onConnected()
  func onDisconnected(_ reason: String?)
  func onConnectionError(_ reason: String)
  func onText(_ text: String)
}

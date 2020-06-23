//
//  ChatViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/23/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  var viewModel: ChatViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    viewModel.connect()
  }
}

extension ChatViewController: ChatViewModelDelegate {
  func didUpdateState() {
    //TODO
  }
  
  func didUpdateNetworkState() {
    switch viewModel.networkState {
    case .loading:
      UIApplication.showNetworkActivity()
    case .idle:
      UIApplication.hideNetworkActivity()
    case .error(let errorDescription):
      UIApplication.hideNetworkActivity()
      showMessage(title: "Error", message: errorDescription)
    }
  }
}

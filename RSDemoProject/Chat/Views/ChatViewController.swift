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
  let sendMessagesButtonRadius: CGFloat = 17
  
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var topicIconImageView: UIImageView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var targetDeletedErrorLabel: UILabel!
  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatMessageTextField: UITextField!
  @IBOutlet weak var sendMessageButton: UIButton!
  
  let tableCellIdentifier = ChatItemTableViewCell.identifier
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpTableView()
    viewModel.delegate = self
    viewModel.connect()
    setUpView()
    viewModel.loadMessages()
  }
  
  func setUpTableView() {
    let nib = UINib(nibName: tableCellIdentifier, bundle: nil)
    chatTableView.register(
      nib,
      forCellReuseIdentifier: tableCellIdentifier
    )

    chatTableView.dataSource = self
    chatTableView.delegate = self
  }
  
  func setUpView() {
    sendMessageButton.setRoundBorders(sendMessagesButtonRadius)
    sendMessageButton.setImage(R.image.backArrow(), for: .normal)
    
    userNameLabel.text = viewModel.userName
    topicIconImageView.kf.setImage(with: viewModel.topicIconURL)
  }
  
  @IBAction func backButton(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
}

extension ChatViewController: ChatViewModelDelegate {
  func didUpdateState() {
    switch viewModel.state {
    case .messageSent:
      //TODO: 
      break
    case .messagesLoaded:
      chatTableView.reloadData()
    case .none:
      break
    }
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

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.messagesCount
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: tableCellIdentifier,
      for: indexPath
    )

    guard
      let messageCell = cell as? ChatItemTableViewCell,
      let message = viewModel.getMessage(at: indexPath.row)
    else {
      return cell
    }
    
    messageCell.viewModel = MessageViewModel(message)
    return messageCell
  }
}

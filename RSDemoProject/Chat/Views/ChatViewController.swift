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
  @IBOutlet weak var topicIconImage: UIImageView!
  @IBOutlet weak var backButton: UIButton!
  @IBOutlet weak var targetDeletedErrorLabel: UILabel!
  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatMessageTextField: UITextField!
  @IBOutlet weak var sendMessageButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    viewModel.connect()
    
    setUpView()
  }
  
  func setUpView() {
    sendMessageButton.setRoundBorders(sendMessagesButtonRadius)
    sendMessageButton.setImage(R.image.backArrow(), for: .normal)
    
    userNameLabel.text = viewModel.userName
    topicIconImage.kf.setImage(with: viewModel.topicIconURL)
    
    let nib = UINib(nibName: ChatItemTableViewCell.identifier, bundle: nil)
    chatTableView.register(
      nib,
      forCellReuseIdentifier: ChatItemTableViewCell.identifier
    )
    chatTableView.dataSource = self
    chatTableView.delegate = self
    chatTableView.separatorColor = .none
  }
  
  @IBAction func backButton(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
}

extension ChatViewController: ChatViewModelDelegate {
  func didUpdateState() {
    switch viewModel.state {
    case .messageSent:
      //todo
      break
    case .messagesLoaded:
      //todo
      break
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
    viewModel.countMessages
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: ChatItemTableViewCell.identifier,
      for: indexPath
    )
    
    guard let messageCell = cell as? ChatItemTableViewCell else {
      return cell
    }
    
    messageCell.viewModel = MessageViewModel(viewModel.getMessage(at: indexPath.row))
    return messageCell
  }
}

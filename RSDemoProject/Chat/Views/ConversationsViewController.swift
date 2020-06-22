//
//  ConversationsViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/19/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class ConversationsViewController: UIViewController {
  
  @IBOutlet weak var conversationsTableView: UITableView!
  var viewModel: ConversationsViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    setUpView()
    viewModel.loadConversations()
  }
  
  func setUpView() {
    let nib = UINib(nibName: ConversationTableViewCell.identifier, bundle: nil)
    conversationsTableView.register(
      nib,
      forCellReuseIdentifier: ConversationTableViewCell.identifier
    )
    conversationsTableView.dataSource = self
    conversationsTableView.delegate = self
    conversationsTableView.separatorColor = .none
  }
  
  func openChat() {
    //TODO: open chat view controller
  }
  
  @IBAction func openUserSettings(_ sender: Any) {
    navigateTo(ProfileRoutes.editProfile)
  }
  
  @IBAction func backToMap(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
}

extension ConversationsViewController: ConversationsViewModelDelegate {
  func didUpdateState() {
    switch viewModel.state {
    case .conversationSelected:
      openChat()
    case .conversationsLoaded:
      conversationsTableView.reloadData()
    default:
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

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.countConversations
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: ConversationTableViewCell.identifier,
      for: indexPath
    )
    
    guard let conversationCell = cell as? ConversationTableViewCell else {
      return cell
    }
    
    conversationCell.viewModel = viewModel
    conversationCell.row = indexPath.row

    return conversationCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectConversation(at: indexPath.row)
  }
}

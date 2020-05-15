//
//  TopicListViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class TopicListViewController: UITableViewController {
  
  var viewModel: TopicListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: TopicTableViewCell.identifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TopicTableViewCell.identifier)
    tableView.separatorStyle = .none
    
    clearsSelectionOnViewWillAppear = false
    viewModel.delegate = self
  }

  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.countTopics()
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: TopicTableViewCell.identifier,
      for: indexPath
    )
    
    guard let topicCell = cell as? TopicTableViewCell else {
      return cell
    }
    
    topicCell.topic = viewModel.getTopic(indexPath.row)

    return topicCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectTopic(indexPath.row)
  }
}

extension TopicListViewController: TopicListDelegate {
  func didUpdateTopicListState() {
    switch viewModel.state {
    case .didLoadTopics:
      self.tableView.reloadData()
    case .didTopicSelected:
      //todo: back with the selected topic
      break
    case .none:
      break
    }
  }

  func didUpdateState() {
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

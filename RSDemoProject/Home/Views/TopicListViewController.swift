//
//  TopicListViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class TopicListViewController: UITableViewController {
  
  var items = [Topic]()
  var selectedItem: Topic!
  var viewModel: TopicListViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: TopicTableViewCell.identifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TopicTableViewCell.identifier)
    tableView.separatorStyle = .none
    
    clearsSelectionOnViewWillAppear = false
    viewModel.delegate = self
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    items.count
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
    
    topicCell.topic = items[indexPath.row]

    return topicCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedItem = items[indexPath.row]
    //todo: back with the selecteditem
  }
}

extension TopicListViewController: TopicListDelegate {
  func didUpdateTopicListState() {
    switch viewModel.state {
    case .didLoadTopics:
      items = viewModel.topics
      self.tableView.reloadData()
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

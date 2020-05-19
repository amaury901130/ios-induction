//
//  TopicListViewController.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class TopicListViewController: UIViewController {
  
  var viewModel: TopicListViewModel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var dismissRegionView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }

  func setUpView() {
    let nib = UINib(nibName: TopicTableViewCell.identifier, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: TopicTableViewCell.identifier)
    tableView.dataSource = self
    tableView.delegate = self
    
    dismissRegionView.addGestureRecognizer(
      UITapGestureRecognizer(
        target: self,
        action: #selector(dismissController)
    ))
    
    viewModel.delegate = self
  }
  
  @objc func dismissController() {
     dismiss(animated: true, completion: nil)
  }
}

extension TopicListViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModel.countTopics()
  }
  
  func tableView(
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
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.selectTopic(indexPath.row)
  }
}

extension TopicListViewController: TopicListDelegate {
  func didUpdateTopicListState() {
    switch viewModel.state {
    case .didLoadTopics:
      tableView.reloadData()
    case .didSelectTopic:
      dismissController()
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

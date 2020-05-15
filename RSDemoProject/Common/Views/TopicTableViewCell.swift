//
//  TopicTableViewCell.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 5/14/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
  
  static let identifier = "TopicTableViewCell"
  
  @IBOutlet weak var topicIcon: UIImageView!
  @IBOutlet weak var topicLabel: UILabel!

  var topic: Topic! {
    didSet {
      topicLabel.text = topic.label
      topicIcon.kf.setImage(with: URL(string: topic.icon))
    }
  }
}

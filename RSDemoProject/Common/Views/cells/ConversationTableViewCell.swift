//
//  ConversationTableViewCell.swift
//  RSDemoProject
//
//  Created by Amaury Ricardo on 6/19/20.
//  Copyright © 2020 TopTier labs. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {
  
  static let identifier = "ConversationTableViewCell"
  @IBOutlet weak var userAvatar: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var conversationLastMessageLabel: UILabel!
  @IBOutlet weak var topicIcon: UIImageView!
  @IBOutlet weak var unreadMessagesLabel: UILabel!
  
  var viewModel: ConversationViewModel! {
    didSet {
      userNameLabel.text = viewModel.getUserFullName()
      userAvatar.kf.setImage(
        with: viewModel.getUserAvatar(),
        placeholder: R.image.avatarPlaceholder()
      )
      conversationLastMessageLabel.text = viewModel.latestMessage()
      topicIcon.kf.setImage(with: viewModel.getTopicIcon())
      
      let unreadMessages = viewModel.unreadMessage()
      unreadMessagesLabel.isHidden = unreadMessages == 0
      unreadMessagesLabel.setRoundBorders(8)
      unreadMessagesLabel.text = "\(unreadMessages)"
    }
  }
}

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
  
  var conversation: Conversation! {
    didSet {
      userNameLabel.text = conversation.user?.fullName
      userAvatar.kf.setImage(
        with: URL(string: conversation.user?.avatar?.smallUrl ?? ""),
        placeholder: R.image.avatarPlaceholder()
      )
      conversationLastMessageLabel.text = conversation.lastMessage ?? ""
      topicIcon.kf.setImage(with: URL(string: conversation.topicIcon))
      
      unreadMessagesLabel.isHidden = conversation.unreadMessages == 0
      unreadMessagesLabel.setRoundBorders(8)
      unreadMessagesLabel.text = "\(conversation.unreadMessages)"
    }
  }
}

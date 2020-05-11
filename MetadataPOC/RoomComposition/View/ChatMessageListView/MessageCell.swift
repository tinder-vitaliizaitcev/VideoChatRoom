//
//  MessageCell.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

class MessageCell: UITableViewCell {
    static let Identifier: String = "MessageCellIdentifier"
        
    private let senderLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15.0)
        label.numberOfLines = 1
        label.textColor = .black
        
        return label
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 0
        label.textColor = .black

        return label
    }()

    var sender: String? {
        get { senderLabel.text }
        set { senderLabel.text = newValue }
    }

    var message: String? {
        get { messageLabel.text }
        set { messageLabel.text = newValue }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(senderLabel)
        addSubview(messageLabel)

        constrain(senderLabel, messageLabel) { sender, message in
            sender.top      == sender.superview!.top + 8.0
            sender.left     == sender.superview!.left + 8.0
            sender.right    == sender.superview!.right - 8.0
            
            message.top     == sender.bottom + 4.0
            message.left    == sender.left
            message.right   == sender.right
            message.bottom  == message.superview!.bottom - 8.0

        }
    }
}

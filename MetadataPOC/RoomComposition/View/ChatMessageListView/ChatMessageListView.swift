//
//  ChatMessageListView.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

protocol ChatMessageListViewType: class {
    var viewModel: ChatMessageListViewModelType? { get set }
}

class ChatMessageListView: UIView, ChatMessageListViewType {
    var viewModel: ChatMessageListViewModelType?
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor       = .clear
        tableView.keyboardDismissMode   = .onDrag
        tableView.separatorStyle        = .none
        tableView.tableHeaderView       = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        tableView.tableFooterView       = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        tableView.sectionHeaderHeight   = 0.0
        tableView.sectionFooterHeight   = 0.0
        tableView.rowHeight             = UITableView.automaticDimension
        tableView.estimatedRowHeight    = 44.0
        tableView.contentInset          = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.clipsToBounds         = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        return tableView
    }()

    init(viewModel: ChatMessageListViewModelType) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func commonInit() {
        viewModel?.uiInputs = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.Identifier)
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(tableView)

        constrain(tableView) {
            $0.edges == $0.superview!.edges
        }
    }
}

// MARK: - ChatMessageListViewModelUIInputs
extension ChatMessageListView: ChatMessageListViewModelUIInputs {
    func onReceiveNewMessage() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension ChatMessageListView: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension ChatMessageListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel?.messages.count ?? 0 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageCell = tableView.dequeueReusableCell(withIdentifier: MessageCell.Identifier) as! MessageCell
        
        let message: Message? = viewModel?.messages[indexPath.row]
        
        cell.sender = message?.sender
        cell.message = message?.text

        return cell
    }
}

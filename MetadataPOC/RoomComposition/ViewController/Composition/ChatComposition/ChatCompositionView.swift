//
//  ChatCompositionView.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

class ChatCompositionView: UIView, CompositionView {
    var mainView: UIView { return self }

    var viewModel: ChatCompositionViewModelType? {
        didSet {
            if let viewModel = viewModel?.chatMessageViewModel {
                chatMessageView = ChatMessageView.init(viewModel: viewModel)
            }
            
            if let viewModel = viewModel?.chatMessageListViewModel {
                chatMessageListView = ChatMessageListView.init(viewModel: viewModel)
            }
            
            setupSubviews()
        }
    }

    private var chatMessageView: ChatMessageView?

    private var chatMessageListView: ChatMessageListView?

    init(viewModel: ChatCompositionViewModelType = ChatCompositionViewModel()) {
        self.viewModel = viewModel
        self.chatMessageView = ChatMessageView.init(viewModel: viewModel.chatMessageViewModel)
        self.chatMessageListView = ChatMessageListView.init(viewModel: viewModel.chatMessageListViewModel)

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
        setupSubviews()
    }
    
    private func setupSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
        
        guard let chatMessageView = chatMessageView,
            let chatMessageListView = chatMessageListView else { return }

        addSubview(chatMessageView)
        addSubview(chatMessageListView)
        
        constrain(chatMessageView, chatMessageListView) { message, list in
            list.top        == list.superview!.top
            list.left       == list.superview!.left
            list.right      == list.superview!.right
            list.bottom     == message.top
            
            message.left    == message.superview!.left
            message.right   == message.superview!.right
            message.bottom  == message.superview!.safeAreaLayoutGuide.bottom
            message.height  == 60.0
        }
    }
}

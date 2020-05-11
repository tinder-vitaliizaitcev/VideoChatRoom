//
//  ChatRoomContext.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

class ChatRoomContext: Context {
    let viewModel: ChatCompositionViewModelType
    
    private var messages: [Message] = []
    
    init(viewModel: ChatCompositionViewModelType = ChatCompositionViewModel()) {
        self.viewModel = viewModel
        
        setupInputObservers()
        setupOutputObservers()
    }
    
    func setupInputObservers() {
        viewModel.dataOutputs.onCancelSession {
            print("Cancel session")
        }
        viewModel.chatMessageViewModel.dataOutputs.onSendMessage { [weak self] (message) in
            self?.createNewMessage(message)
        }
    }
    
    func setupOutputObservers() {
        
    }
}

extension ChatRoomContext {
    private func createNewMessage(_ text: String) {
        let message: Message = .init(sender: "Some random dude \(Int.random(in: 0..<10))", text: text)
        
        viewModel.chatMessageListViewModel.dataInputs.onReceiveNewMessage(message)
        
        messages.append(message)
    }
}

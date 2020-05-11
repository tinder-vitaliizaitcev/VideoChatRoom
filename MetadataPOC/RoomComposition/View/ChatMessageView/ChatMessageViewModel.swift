//
//  ChatMessageViewModel.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

protocol ChatMessageViewModelInputs: class {}

protocol ChatMessageViewModelOutputs: class {
    @discardableResult
    func onSendMessage(_ closure: @escaping Callback<String>) -> Self
}

protocol ChatMessageViewModelType: class {
    var dataInputs: ChatMessageViewModelInputs { get }
    var dataOutputs: ChatMessageViewModelOutputs { get }
    
    func sendMessage(_ message: String?, completion: Callback<Bool>)
}

final class ChatMessageViewModel: ChatMessageViewModelType {
    // MARK: - Public
    var dataInputs: ChatMessageViewModelInputs { return self }
    
    var dataOutputs: ChatMessageViewModelOutputs { return self }

    // MARK: - Private

    private var onSendMessage: Callback<String>?
    
    func sendMessage(_ message: String?, completion: Callback<Bool>) {
        guard let message = message,
            !message.isEmpty else { completion(false) ; return }

        onSendMessage?(message)
        completion(true)
    }
}

// MARK: - ChatMessageViewModelInputs
extension ChatMessageViewModel: ChatMessageViewModelInputs { }

// MARK: - ChatMessageViewModelOutputs
extension ChatMessageViewModel: ChatMessageViewModelOutputs {
    @discardableResult
    func onSendMessage(_ closure: @escaping Callback<String>) -> Self {
        onSendMessage = closure
        return self
    }
}

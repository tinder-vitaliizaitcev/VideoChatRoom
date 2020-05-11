//
//  ChatMessageListViewModel.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

protocol ChatMessageListViewModelUIInputs: class {
    func onReceiveNewMessage()
}

protocol ChatMessageListViewModelInputs: class {
    func onReceiveNewMessage(_ message: Message)
}

protocol ChatMessageListViewModelOutputs: class {}

// Protocol describing proposed View Model
protocol ChatMessageListViewModelType: class {
    var dataInputs: ChatMessageListViewModelInputs { get }
    var dataOutputs: ChatMessageListViewModelOutputs { get }
    
    var uiInputs: ChatMessageListViewModelUIInputs? { set get }
    
    var messages: [Message] { get set }
}

final class ChatMessageListViewModel: ChatMessageListViewModelType {
    var messages: [Message] = []
    
    // MARK: - Public
    var dataInputs: ChatMessageListViewModelInputs { return self }
    
    var dataOutputs: ChatMessageListViewModelOutputs { return self }
    
    weak var uiInputs: ChatMessageListViewModelUIInputs?
}


// MARK: - ChatMessageListViewModelInputs
extension ChatMessageListViewModel: ChatMessageListViewModelInputs {
    func onReceiveNewMessage(_ message: Message) {
        messages.append(message)
        uiInputs?.onReceiveNewMessage()
    }
}

// MARK: - ChatMessageListViewModelOutputs
extension ChatMessageListViewModel: ChatMessageListViewModelOutputs {}

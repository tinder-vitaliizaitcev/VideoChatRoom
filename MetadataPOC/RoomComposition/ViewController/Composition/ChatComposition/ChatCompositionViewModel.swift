//
//  ChatCompositionViewModel.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

protocol ChatCompositionViewModelInputs: class {}

protocol ChatCompositionViewModelOutputs: class {
    @discardableResult
    func onCancelSession(_ closure: @escaping Closure) -> Self
}

protocol ChatCompositionViewModelType: class {
    var dataInputs: ChatCompositionViewModelInputs { get }
    var dataOutputs: ChatCompositionViewModelOutputs { get }
    
    var chatMessageViewModel: ChatMessageViewModelType { get }
    var chatMessageListViewModel: ChatMessageListViewModelType { get }
}

final class ChatCompositionViewModel: ChatCompositionViewModelType {
    // MARK: - Public
    var dataInputs: ChatCompositionViewModelInputs { self }
    
    var dataOutputs: ChatCompositionViewModelOutputs { self }
    
    var chatMessageListViewModel: ChatMessageListViewModelType
    
    var chatMessageViewModel: ChatMessageViewModelType

    // MARK: - Private
    
    var onCancelSession: Closure?
    
    init(chatMessageListViewModel: ChatMessageListViewModelType = ChatMessageListViewModel(),
         chatMessageViewModel: ChatMessageViewModelType = ChatMessageViewModel()) {
        self.chatMessageListViewModel = chatMessageListViewModel
        self.chatMessageViewModel = chatMessageViewModel
    }
}

// MARK: - ChatCompositionViewModelInputs
extension ChatCompositionViewModel: ChatCompositionViewModelInputs { }

// MARK: - ChatCompositionViewModelOutputs
extension ChatCompositionViewModel: ChatCompositionViewModelOutputs {
    @discardableResult
    func onCancelSession(_ closure: @escaping Closure) -> Self {
        onCancelSession = closure
        return self
    }
}

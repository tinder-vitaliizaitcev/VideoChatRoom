//
//  RoomCompositionFlow.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

class RoomCompositionFlow: FlowType {
    // MARK: - Public
    var rootViewController: UINavigationController

    private var context: Context

    var childrenFlows: [FlowType] = .init()

    var dataOutput: FlowOutputProtocol { return self }

    // MARK: - Private
    private var onDidStartFlow: Closure?
    
    private var onDidFinishFlow: Closure?
    
    private let compositionType: RoomCompositionType

    init(rootViewController: UINavigationController,
         compositionType: RoomCompositionType) {
        self.context = compositionType.context
        self.compositionType = compositionType
        self.rootViewController = rootViewController
    }
    
    func onStartFlow() {
        switch compositionType {
        case .chat(let chatContext):
            let chatRoomComposition: CompositionView = ChatCompositionView.init(viewModel: chatContext.viewModel)
            let chatRoomCompositionVC = RoomCompositionViewController.init(compositionView: chatRoomComposition)
            
            rootViewController.pushViewController(chatRoomCompositionVC, animated: true)
        }
        
        onDidStartFlow?()
    }
    
    func onFinishFlow() {
        onDidFinishFlow?()
    }
}

extension RoomCompositionFlow: FlowOutputProtocol {
    @discardableResult
    func onDidStartFlow(_ closure: @escaping Closure) -> Self {
        onDidStartFlow = closure
        return self
    }
    
    @discardableResult
    func onDidFinishFlow(_ closure: @escaping Closure) -> Self {
        onDidFinishFlow = closure
        return self
    }
}

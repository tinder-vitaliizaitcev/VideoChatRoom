//
//  AppFlow.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 4/29/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

class AppFlow: FlowType {
    // MARK: - Public
    var rootViewController: UINavigationController
    
    private var context: AppContext

    var childrenFlows: [FlowType] = .init()

    var dataOutput: FlowOutputProtocol { return self }

    // MARK: - Private
    private var onDidStartFlow: Closure?
    
    private var onDidFinishFlow: Closure?

    init(rootViewController: UINavigationController, context: AppContext) {
        self.context = context
        self.rootViewController = rootViewController
    }

    func onStartFlow() {
        let roomsFlow: RoomsFlow = AppRouter.getRoomsFlow(rootViewController)
        roomsFlow.onStartFlow()
        childrenFlows.append(roomsFlow)
        
        onDidStartFlow?()
    }
    
    func onFinishFlow() {
        onDidFinishFlow?()
    }
}

extension AppFlow: FlowOutputProtocol {
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

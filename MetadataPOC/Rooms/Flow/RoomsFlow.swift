//
//  RoomsFlow.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

class RoomsFlow: FlowType {
    // MARK: - Public
    var rootViewController: UINavigationController

    private var context: RoomsContext

    var childrenFlows: [FlowType] = .init()

    var dataOutput: FlowOutputProtocol { return self }

    // MARK: - Private
    private var onDidStartFlow: Closure?
    
    private var onDidFinishFlow: Closure?

    init(rootViewController: UINavigationController, context: RoomsContext) {
        self.context = context
        self.rootViewController = rootViewController
    }
    
    func onStartFlow() {
        let roomsViewController: RoomSelectionViewController = .init(viewModel: context.viewModel)
        rootViewController.pushViewController(roomsViewController, animated: true)
        
        context.onShowRoomFlow { [weak self] (room) in
            guard let self = self else { return }
           
            print("Show here")
            let flow = AppRouter.getChatRoomFlow(self.rootViewController)
            flow.onStartFlow()
            
            self.childrenFlows.append(flow)
        }
        
        onDidStartFlow?()
    }
    
    func onFinishFlow() {
        onDidFinishFlow?()
    }
}

extension RoomsFlow: FlowOutputProtocol {
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

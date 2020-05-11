//
//  DiscoverBaseProtocols.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 4/29/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

typealias Closure = () -> Void
typealias Callback<T> = (T) -> Void

protocol FlowType {
    var rootViewController: UINavigationController { get set }
        
    var dataOutput: FlowOutputProtocol { get }

    // Track all children flows that come out from this (parent) flow
    var childrenFlows: [FlowType] { get set }

    // Initiate start view controller of the flow and display it
    func onStartFlow()
    // Need to properly finish all children flows (save data, send analytics, notify user, etc..)
    // When all children flows are deallocated need to call onFinishFlow to notify parent it's completed
    func onFinishFlow()
}

protocol FlowOutputProtocol {
    @discardableResult
    func onDidStartFlow(_ closure: @escaping Closure) -> Self
    @discardableResult
    func onDidFinishFlow(_ closure: @escaping Closure) -> Self
}

protocol Context {
    func setupInputObservers()
    func setupOutputObservers()
}

protocol Interactor { }

protocol NetworkService { }

protocol Analytics {
    func setupInputObservers()
}


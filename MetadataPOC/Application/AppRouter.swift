//
//  AppRouter.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

struct AppRouter {
    static func getRoomsFlow(_ navigationController: UINavigationController) -> RoomsFlow {
        let viewModel = RoomSelectionViewModel.init()
        let context = RoomsContext.init(viewModel: viewModel)
        
        return .init(rootViewController: navigationController, context: context)
    }
    
    static func getChatRoomFlow(_ navigationController: UINavigationController) -> RoomCompositionFlow {
        let viewModel = ChatCompositionViewModel()
        let context = ChatRoomContext(viewModel: viewModel)
        
        return .init(rootViewController: navigationController, compositionType: .chat(context: context))
    }
}

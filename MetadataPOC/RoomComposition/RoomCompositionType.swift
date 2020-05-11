//
//  RoomCompositionType.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

enum RoomCompositionType {
//    case oneOnOne
//    case oneToMany
    case chat(context: ChatRoomContext)
    
    var context: Context {
        switch self {
        case .chat(let context):
            return context
        }
    }
}

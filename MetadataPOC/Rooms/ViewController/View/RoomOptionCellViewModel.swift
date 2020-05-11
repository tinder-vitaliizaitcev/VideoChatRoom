//
//  RoomOptionCellViewModel.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

// Protocol to receive data from Main View Model
protocol RoomOptionCellViewModelInputs: class {
    func update(room: Room)
}

// Protocol to send data to Main View Model
protocol RoomOptionCellViewModelOutputs: class {
    @discardableResult
    func onSelectRoom(_ closure: @escaping Callback<Room>) -> Self
}

// Protocol describing propossed View Model
protocol RoomOptionCellViewModelType: class {
    var room: Room { get set }
    
    var onUpdateRoom: Closure? { get set } // Sends event to UI to update data TO DO: move to UI
    
    var dataInputs: RoomOptionCellViewModelInputs { get }
    var dataOutputs: RoomOptionCellViewModelOutputs { get }
    
    func selectRoom()
}

final class RoomOptionCellViewModel: RoomOptionCellViewModelType {
    var room: Room
    
    var onUpdateRoom: Closure?
    
    private var onSelectRoom: Callback<Room>?

    var dataInputs: RoomOptionCellViewModelInputs { return self }
    
    var dataOutputs: RoomOptionCellViewModelOutputs { return self }
        
    init(room: Room) {
        self.room = room
    }
    
    func selectRoom() {
        onSelectRoom?(self.room)
    }
}

// MARK: - RoomSelectionViewModelInputs
extension RoomOptionCellViewModel: RoomOptionCellViewModelInputs {
    func update(room: Room) {
        self.room = room
    }
}

// MARK: - RoomOptionCellViewModelOutputs
extension RoomOptionCellViewModel: RoomOptionCellViewModelOutputs {
    @discardableResult
    func onSelectRoom(_ closure: @escaping Callback<Room>) -> Self {
        onSelectRoom = closure
        
        return self
    }
}

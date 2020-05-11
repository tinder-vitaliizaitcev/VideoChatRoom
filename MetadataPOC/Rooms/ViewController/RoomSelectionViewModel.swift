//
//  RoomSelectionViewModel.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

// Protocol to receive data from Context or any other DataService
protocol RoomSelectionViewModelInputs: class {
    func updateAvailableRooms(_ rooms: [Room])
}

// Protocol to send data to Context or any other Interactor Service
protocol RoomSelectionViewModelOutputs: class {
    @discardableResult
    func onSelectRoom(_ closure: @escaping Callback<Room>) -> Self
}

// Protocol describing proposed View Model
protocol RoomSelectionViewModelType: class {
    var rooms: [RoomOptionCellViewModelType] { get set }
    
    var onUpdateRooms: Closure? { get set } // Sends event to UI to update data TO DO: move to UI
    
    var dataInputs: RoomSelectionViewModelInputs { get }
    var dataOutputs: RoomSelectionViewModelOutputs { get }
}

final class RoomSelectionViewModel: RoomSelectionViewModelType {
    // MARK: - Public
    var rooms: [RoomOptionCellViewModelType] = [] {
        didSet {
            onUpdateRooms?()
        }
    }
    
    var onUpdateRooms: Closure?
    
    var dataInputs: RoomSelectionViewModelInputs { return self }
    
    var dataOutputs: RoomSelectionViewModelOutputs { return self }
    
    // MARK: - Private
    private var onSelectRoom: Callback<Room>?
}

// MARK: - RoomSelectionViewModelInputs
extension RoomSelectionViewModel: RoomSelectionViewModelInputs {
    func updateAvailableRooms(_ rooms: [Room]) {
        self.rooms = rooms.map({ room in
            let viewModel = RoomOptionCellViewModel.init(room: room)
            
            viewModel.onSelectRoom { room in
                self.onSelectRoom?(room)
            }
            
            return viewModel
        })
    }
}

// MARK: - RoomSelectionViewModelOutputs
extension RoomSelectionViewModel: RoomSelectionViewModelOutputs {
    @discardableResult
    func onSelectRoom(_ closure: @escaping Callback<Room>) -> Self {
        onSelectRoom = closure
        return self
    }
}

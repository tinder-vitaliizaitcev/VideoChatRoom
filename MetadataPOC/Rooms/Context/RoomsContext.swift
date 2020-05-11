//
//  RoomsContext.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation

protocol RoomsContextOutputs: class {
    @discardableResult
    func onShowRoomFlow(_ closure: @escaping Callback<Room>) -> Self
}

protocol RoomsContextType: Context {
    var dataOutputs: RoomsContextOutputs { get }
    
    var viewModel: RoomSelectionViewModelType { get }
}

class RoomsContext: RoomsContextType {
    // MARK: - Public
    let viewModel: RoomSelectionViewModelType
    
    var dataOutputs: RoomsContextOutputs { self }

    // MARK: - Private
    private let mockRooms: [Room] = [.init(name: "Room 1"),
                                     .init(name: "Room 2"),
                                     .init(name: "Room 3")]
        
    private var onShowRoomFlow: Callback<Room>?
    
    init(viewModel: RoomSelectionViewModelType) {
        self.viewModel = viewModel
        
        setupInputObservers()
        setupOutputObservers()
    }
    
    func setupInputObservers() {
        viewModel.dataOutputs.onSelectRoom { [weak self] (room) in
            self?.onShowRoomFlow?(room)
        }
    }
    
    func setupOutputObservers() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.dataInputs.updateAvailableRooms(self.mockRooms)
        }
    }
}

// MARK: - RoomsContextOutputs
extension RoomsContext: RoomsContextOutputs {
    @discardableResult
    func onShowRoomFlow(_ closure: @escaping Callback<Room>) -> Self {
        onShowRoomFlow = closure
        return self
    }
}

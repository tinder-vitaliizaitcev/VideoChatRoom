//
//  RoomOptionCell.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

class RoomOptionCell: UITableViewCell {
    static let Identifier: String = "RoomOptionCellIdentifier"
    
    var viewModel: RoomOptionCellViewModelType?
    
    private let roomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10.0
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    var roomTitle: String? {
        get { roomButton.title(for: .normal) }
        set { roomButton.setTitle(newValue, for: .normal) }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(roomButton)
        
        constrain(roomButton) {
            $0.edges == $0.superview!.edges.inseted(by: 12.0)
            $0.height == 40.0
        }
    }
    
    private func setupTargets() {
        roomButton.addTarget(self, action: #selector(didTapShowRoomButton), for: .touchUpInside)
    }
    
    @objc private func didTapShowRoomButton() {
        viewModel?.selectRoom()
    }
    
    func setViewModel(_ viewModel: RoomOptionCellViewModelType) {
        self.viewModel = viewModel
        roomTitle = viewModel.room.name

        viewModel.onUpdateRoom = { [weak self] in
            self?.roomTitle = viewModel.room.name
        }
    }
}

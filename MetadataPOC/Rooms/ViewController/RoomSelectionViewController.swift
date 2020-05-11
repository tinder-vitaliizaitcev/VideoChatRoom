//
//  RoomSelectionViewController.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/9/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

class RoomSelectionViewController: UIViewController {
    private let viewModel: RoomSelectionViewModelType
        
    init(viewModel: RoomSelectionViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor       = .clear
        tableView.keyboardDismissMode   = .onDrag
        tableView.separatorStyle        = .none
        tableView.tableHeaderView       = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        tableView.tableFooterView       = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 0.1))
        tableView.sectionHeaderHeight   = 0.0
        tableView.sectionFooterHeight   = 0.0
        tableView.rowHeight             = UITableView.automaticDimension
        tableView.estimatedRowHeight    = 44.0
        tableView.contentInset          = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.clipsToBounds         = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        return tableView
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupSubviews()
        setupTargets()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RoomOptionCell.self, forCellReuseIdentifier: RoomOptionCell.Identifier)
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
        
        constrain(tableView) { view in
            view.top    == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left   == view.superview!.left
            view.right  == view.superview!.right
        }
    }
    
    private func setupTargets() {
        viewModel.onUpdateRooms = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension RoomSelectionViewController: UITableViewDelegate { }

// MARK: - UITableViewDelegate
extension RoomSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RoomOptionCell = tableView.dequeueReusableCell(withIdentifier: RoomOptionCell.Identifier) as! RoomOptionCell
        
        cell.setViewModel(viewModel.rooms[indexPath.row])
        
        return cell
    }
}

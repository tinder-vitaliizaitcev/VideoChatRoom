//
//  RoomCompositionViewController.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

class RoomCompositionViewController: UIViewController, CompositionViewController {
    var compositionView: CompositionView
        
    init(compositionView: CompositionView) {
        self.compositionView = compositionView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = .white

        view.addSubview(compositionView.mainView)
        
        constrain(compositionView.mainView) { $0.edges == $0.superview!.edges }
    }
}

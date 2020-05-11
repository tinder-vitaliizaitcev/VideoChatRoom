//
//  CompositionProtocols.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import Foundation
import UIKit

protocol CompositionView: class {
    var mainView: UIView { get }
}

protocol CompositionViewController: class {
    var compositionView: CompositionView { get set }
}

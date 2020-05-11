//
//  ChatMessageView.swift
//  MetadataPOC
//
//  Created by Vitalii Zaitcev on 5/10/20.
//  Copyright © 2020 Vitalii Zaitcev. All rights reserved.
//

import UIKit
import Cartography

protocol ChatMessageViewType: class {
    var viewModel: ChatMessageViewModelType? { get set }
}

class ChatMessageView: UIView, ChatMessageViewType {
    var viewModel: ChatMessageViewModelType?
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private let textFieldBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor

        return view
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.returnKeyType = .send
        textField.borderStyle = .none
        textField.placeholder = "Enter your message"
        
        return textField
    }()
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var textMessage: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    init(viewModel: ChatMessageViewModelType) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textFieldBGView.layer.cornerRadius = textFieldBGView.frame.height / 2
    }
    
    private func commonInit() {
        textField.delegate = self
        
        setupSubviews()
        setupTargets()
    }
    
    func setupSubviews() {
        addSubview(separatorView)
        addSubview(textFieldBGView)
        addSubview(sendButton)

        constrain(separatorView, textFieldBGView, sendButton) { separator, view, button in
            separator.top       == separator.superview!.top
            separator.right     == separator.superview!.right
            separator.left      == separator.superview!.left
            separator.height    == 1.0
            
            view.top            == separator.bottom + 4.0
            view.left           == view.superview!.left + 8.0
            view.bottom         == view.superview!.bottom - 8.0
            
            button.top          == separator.bottom + 4.0
            button.right        == button.superview!.right - 8.0
            button.left         == view.right + 8.0
            button.bottom       == button.superview!.bottom - 8.0
            button.width        == 50.0
        }
        
        textFieldBGView.addSubview(textField)

        constrain(textField) {
            $0.edges == $0.superview!.edges.inseted(by: 4.0)
        }
    }
    
    private func setupTargets() {
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
    }
    
    @objc private func didTapSendButton() {
        viewModel?.sendMessage(textField.text, completion: { [weak self] (success) in
            if success {
                self?.textMessage = nil
            }
        })
    }
}

extension ChatMessageView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapSendButton()
        
        return false
    }
}

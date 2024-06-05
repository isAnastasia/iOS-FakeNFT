//
//  TextViews.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

enum TextViewStyle {
    case defaultTVStyle
}

final class TextViews: UITextView, UITextViewDelegate {
    
    // MARK: - Private Properties
    private var currentStyle: TextViewStyle?
    private var textChangeAction: ((UITextView) -> Void)?
    
    // MARK: - Initializers
    init(style: TextViewStyle, textChangeAction: ((UITextView) -> Void)?) {
        self.textChangeAction = textChangeAction
        super.init(frame: .zero, textContainer: nil)
        self.delegate = self
        commonInit(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TextView cases
    private func commonInit(style: TextViewStyle) {
        currentStyle = style
        switch style {
        case .defaultTVStyle:
            self.backgroundColor = .lightGrayDay
            self.layer.cornerRadius = 12
            self.clipsToBounds = true
            self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            self.heightAnchor.constraint(equalToConstant: 132).isActive = true
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChangeAction?(textView)
    }
}



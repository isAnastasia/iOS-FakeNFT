//
//  TextFields.swift
//  FakeNFT
//
//  Created by Dmitry Dmitry on 25.5.2024.
//

import UIKit

enum TextFieldStyle {
    case defaultTFStyle
}

final class TextFields: UITextField, UITextFieldDelegate {
    
    // MARK: - Private Properties
    private var currentStyle: TextFieldStyle?
    
    // MARK: - Initializers
    init(style: TextFieldStyle, target: Any?, action: Selector?) {
        super.init(frame: .zero)
        self.delegate = self
        commonInit(style: style)
        
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: .editingChanged)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TextField cases
    private func commonInit(style: TextFieldStyle) {
        currentStyle = style
        switch style {
        case .defaultTFStyle:
            self.backgroundColor = .lightGrayDay
            self.layer.cornerRadius = 12
            self.clipsToBounds = true
            
            let paddingViewLeft = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: 16,
                    height: self.frame.height
                )
            )
            
            self.leftView = paddingViewLeft
            self.leftViewMode = .always
            
            let clearButton = UIButton(type: .custom)
            let clearImage = UIImage(
                systemName: "xmark.circle.fill")?
                .withTintColor(
                    .closeButtonColor,
                    renderingMode: .alwaysOriginal
                )
            clearButton.setImage(clearImage, for: .normal)
            clearButton.addTarget(
                self,
                action: #selector(clearText),
                for: .touchUpInside
            )
            
            self.rightView = clearButton
            self.rightViewMode = .whileEditing
            
            self.heightAnchor.constraint(equalToConstant: 44).isActive = true
            self.translatesAutoresizingMaskIntoConstraints = false
            self.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        }
    }
    
    // MARK: - Private Methods
    @objc private func clearText() {
        self.text = ""
    }
    
    // MARK: - UITextFieldDelegate
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.rightViewRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -16, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 40))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 40))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

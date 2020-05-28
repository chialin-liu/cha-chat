//
//  CustomTextField.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/28.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

//    let padding: CGFloat
//    let height: CGFloat
//
//    init(padding: CGFloat, height: CGFloat) {
//        self.padding = padding
//        self.height = height
//        super.init(frame: .zero)
//        layer.cornerRadius = height / 2
//    }
//
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: padding, dy: 0)
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 44 / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 44)
    }
    

}

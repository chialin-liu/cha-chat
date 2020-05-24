//
//  HomeBottomControllerStackView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class HomeBottomControllerStackView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let left = UIButton(type: .system)
        left.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let right = UIButton(type: .system)
        right.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addArrangedSubview(left)
        addArrangedSubview(right)
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

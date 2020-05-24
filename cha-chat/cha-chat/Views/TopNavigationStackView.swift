//
//  topNavigationStackView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let left = UIButton(type: .system)
    let mid = UIButton(type: .system)
    let right = UIButton(type: .system)
    override init(frame: CGRect) {
        super.init(frame: frame)
        left.setImage(UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal), for: .normal)
        mid.setImage(UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal), for: .normal)
        right.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addArrangedSubview(left)
        addArrangedSubview(mid)
        addArrangedSubview(right)
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

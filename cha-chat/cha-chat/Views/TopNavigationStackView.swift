//
//  topNavigationStackView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {
    let leftButton = UIButton(type: .system)
    let midButton = UIButton(type: .system)
    let right = UIButton(type: .system)
    override init(frame: CGRect) {
        super.init(frame: frame)
        leftButton.setImage(UIImage(systemName: "list.bullet")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let configLeft = UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold)
        leftButton.setPreferredSymbolConfiguration(configLeft, forImageIn: .normal)
        midButton.setImage(UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal), for: .normal)
        let configMid = UIImage.SymbolConfiguration(pointSize: 32, weight: .semibold)
        midButton.setPreferredSymbolConfiguration(configMid, forImageIn: .normal)
//        right.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addArrangedSubview(leftButton)
        addArrangedSubview(midButton)
//        addArrangedSubview(right)
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

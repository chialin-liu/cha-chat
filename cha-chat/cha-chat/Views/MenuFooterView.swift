//
//  MenuFooterView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/27.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class MenuFooterView: UIView {
    let logout: UIButton = {
        let bt = UIButton()
        bt.setTitle("LogOut", for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .red
        return bt
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logout)
        logout.topAnchor.constraint(equalTo: topAnchor).isActive = true
        logout.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        logout.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        logout.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        logout.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
    }
    @objc func handleLogOut() {
        print("LogOut")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  ViewController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func setupTopStackView() -> UIStackView {
        let stackView = UIStackView()
        let left = UIView()
        left.backgroundColor = .lightGray
        let mid = UIView()
        mid.backgroundColor = .gray
        let right = UIView()
        right.backgroundColor = .black
        stackView.addArrangedSubview(left)
        stackView.addArrangedSubview(mid)
        stackView.addArrangedSubview(right)
        stackView.distribution = .fillEqually
        return stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let topStackView = setupTopStackView()
        let blue = UIView()
        let yellow = UIView()
        topStackView.backgroundColor = .red
        topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        yellow.heightAnchor.constraint(equalToConstant: 120).isActive = true
        blue.backgroundColor = .blue
        yellow.backgroundColor = .yellow
        let stackView = UIStackView()
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(blue)
        stackView.addArrangedSubview(yellow)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        stackView.distribution = .fillEqually
        stackView.axis = .vertical
    }


}


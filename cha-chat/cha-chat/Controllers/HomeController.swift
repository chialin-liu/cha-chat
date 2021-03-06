//
//  ViewController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let topStackView = TopNavigationStackView()
    let botStackView = HomeBottomControllerStackView()
    let menu = MenuTableViewController()
    let menuWidth: CGFloat = 300
    let cardsDeckView = UIView()
    let cardViewModels = [
        User(name: "Thor", age: 24, profession: "Thunder", imageName: ["thor", "thor2"], jogging: false, movie: false, travel: false, chatFirst: false, food: true, star: "天秤").toCardViewModel(),
        User(name: "Tony", age: 30, profession: "IronMan", imageName: ["tony", "tony2", "tony3"], jogging: true, movie: false, travel: false, chatFirst: false, food: false, star: "天蠍").toCardViewModel(),
        User(name: "Cris", age: 30, profession: "Captain", imageName: ["cap"], jogging: false, movie: false, travel: false, chatFirst: false, food: true, star: "巨蠍").toCardViewModel(),
//        User(name: "ABC", age: 20, profession: "ABC", imageName: "questionmark", jogging: false, movie: true, travel: false, chatFirst: false, food: false, star: "天蠍").toCardViewModel()
    ]
    fileprivate func setupMainStackView() {
        let stackView = UIStackView()
        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(cardsDeckView)
        stackView.addArrangedSubview(botStackView)
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.axis = .vertical
        //purpose: because the cardsDeckView after pan-gesture, it will below the botStackView, therefore, bring this view to the front
        stackView.bringSubviewToFront(cardsDeckView)
        //purpose: use to align margin not bounds
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
    }
    func setupCard() {
        for carViewModel in cardViewModels {
            let cardView = CardView()
            cardView.cardViewModel = carViewModel
            cardsDeckView.addSubview(cardView)
            cardView.topAnchor.constraint(equalTo: cardsDeckView.topAnchor).isActive = true
            cardView.leadingAnchor.constraint(equalTo: cardsDeckView.leadingAnchor, constant: 10).isActive = true
            cardView.trailingAnchor.constraint(equalTo: cardsDeckView.trailingAnchor, constant: -10).isActive = true
            cardView.bottomAnchor.constraint(equalTo: cardsDeckView.bottomAnchor).isActive = true
        }
    }

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        topStackView.leftButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
//        topStackView.midButton.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)
        setupMainStackView()
        setupCard()
    }



    @objc func closeMenu() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlideViewController)?.closeMenu()
    }
    @objc func openMenu() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlideViewController)?.openMenu()
    }


}


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
    fileprivate func setupMenu() {
        menu.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        //method 1
//        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
//        keyWindow?.addSubview(menu.view)
//        let mainWindow = UIApplication.shared.keyWindow
//        mainWindow?.addSubview(menu.view)
        //method 2
        view.addSubview(menu.view)
        //used to solve problem
        addChild(menu)
    }
    
    fileprivate func setupPanGesture() {
        //pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        topStackView.leftButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
//        topStackView.midButton.addTarget(self, action: #selector(closeMenu), for: .touchUpInside)
        setupMainStackView()
        setupCard()
//        setupMenu()
//        setupPanGesture()
//        setupDarkCoverView()
    }
    let darkCoverView = UIView()
    func setupDarkCoverView() {
        darkCoverView.frame = view.frame
        view.addSubview(darkCoverView)
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    func removeDarkCoverView() {
        darkCoverView.removeFromSuperview()
    }
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if gesture.state == .began {
//            view.addSubview(darkCoverView)
//            darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        } else if gesture.state == .changed {
            
            var x = translation.x
            if isMenuOpen {
                x += menuWidth
            }
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
//            menu.view.transform = transform
            view.transform = transform
//            view.addSubview(darkCoverView)
            darkCoverView.alpha = x / menuWidth
//            darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.6)
        } else if gesture.state == .ended {
            if isMenuOpen {
                if abs(translation.x) < menuWidth / 3 {
                    openMenu()
                } else {
                    closeMenu()
                }
            } else {
                if translation.x < menuWidth / 3 {
                    closeMenu()
                } else {
                    openMenu()
                }
            }
        }
        
    }
    var isMenuOpen = false
    func performeAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5) {
            self.view.transform = transform
//            self.menu.view.transform = transform
            
            
        }
    }
    @objc func closeMenu() {
//        removeDarkCoverView()
        darkCoverView.alpha = 0
        performeAnimations(transform: .identity)
        isMenuOpen = false
        
//        menu.removeFromParent()
//        menu.view.removeFromSuperview()
    }
    @objc func openMenu() {
//        setupMenu()
//        setupDarkCoverView()
        darkCoverView.alpha = 1
        performeAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
        isMenuOpen = true
        
    }


}


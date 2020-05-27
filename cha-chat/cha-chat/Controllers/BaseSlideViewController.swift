//
//  BaseSlideViewController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/27.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class BaseSlideViewController: UIViewController {
    let menuWidth: CGFloat = 300
    var redViewLeadingConstraint: NSLayoutConstraint!
    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        x = min(x, menuWidth)
        redViewLeadingConstraint.constant = x
//            if gesture.state == .changed {
//                var x = translation.x
//                if isMenuOpen {
//                    x += menuWidth
//                }
//                x = min(menuWidth, x)
//                x = max(0, x)
//                let transform = CGAffineTransform(translationX: x, y: 0)
//                view.transform = transform
//                darkCoverView.alpha = x / menuWidth
//            } else if gesture.state == .ended {
//                if isMenuOpen {
//                    if abs(translation.x) < menuWidth / 3 {
//                        openMenu()
//                    } else {
//                        closeMenu()
//                    }
//                } else {
//                    if translation.x < menuWidth / 3 {
//                        closeMenu()
//                    } else {
//                        openMenu()
//                    }
//                }
//            }
            
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
            redViewLeadingConstraint.constant = 0
            darkCoverView.alpha = 0
            performeAnimations(transform: .identity)
            isMenuOpen = false
            
    //        menu.removeFromParent()
    //        menu.view.removeFromSuperview()
        }
        @objc func openMenu() {
    //        setupMenu()
    //        setupDarkCoverView()
            redViewLeadingConstraint.constant = menuWidth
            darkCoverView.alpha = 1
            performeAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
            isMenuOpen = true
            
        }

    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        // let's go ahead and use Auto Layout
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
//            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        setupViewControllers()
    }

    func setupViewControllers() {
            // let's add back our HomeController into the redView
            let homeController = HomeController()
            let menuController = MenuTableViewController()
            
            let homeView = homeController.view!
            let menuView = menuController.view!
            
            homeView.translatesAutoresizingMaskIntoConstraints = false
//            menuView.translatesAutoresizingMaskIntoConstraints = false
            
            redView.addSubview(homeView)
//            redView.addSubview(darkCoverView)
//            blueView.addSubview(menuView)
            
            NSLayoutConstraint.activate([
                // top, leading, bottom, trailing anchors
                homeView.topAnchor.constraint(equalTo: redView.topAnchor),
                homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
//
//                menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
//                menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
//                menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
//                menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
//
//                darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
//                darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
//                darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
//                darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
                ])
//
            addChild(homeController)
//            addChild(menuController)
    }

}

//
//  BaseSlideViewController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/27.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit
class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}
class BaseSlideViewController: UIViewController {
    let menuWidth: CGFloat = 300
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!
    let homeController = HomeController()
    let menuController = MenuTableViewController()
    let redView: RightContainerView = {
        let v = RightContainerView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let blueView: MenuContainerView = {
        let v = MenuContainerView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let darkCoverView: DarkCoverView = {
        let v = DarkCoverView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupViews()
//        homeController.topStackView.leftButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if isMenuOpened {
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
        var isMenuOpened = false
        func performeAnimations(transform: CGAffineTransform) {
            UIView.animate(withDuration: 0.5) {
                self.view.transform = transform
    //            self.menu.view.transform = transform
                
                
            }
        }
    @objc func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstraint.constant = menuWidth
        performAnimations()
    }
    var rightViewController: UIViewController?
    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        closeMenu()
        switch indexPath.row {
//        case 0:
//            break
//            redView.addSubview(homeController.view)
//            addChild(homeController)
//            rightViewController = homeController
        case 1:
            let vc = UINavigationController(rootViewController: ProfileTableViewController())
            //method 1: is OK
//            present(profile, animated: true, completion: nil)
            //method 2: no use
//            navigationController?.pushViewController(profile, animated: true)
            //method 3
            redView.addSubview(vc.view)
            addChild(vc)
            rightViewController = vc
        case 2:
            let message = MessageTableViewController()
            redView.addSubview(message.view)
            addChild(message)
            rightViewController = message
        case 4:
            let tabBar = UITabBarController()
            let location = UIViewController()
            tabBar.viewControllers = [location]
            location.view.backgroundColor = .orange
            redView.addSubview(tabBar.view)
            addChild(tabBar)
            rightViewController = tabBar
//        case 3:
//            break
        default:
            break
        }
        redView.bringSubviewToFront(darkCoverView)
        
    }
    func performRightViewCleanUp() {
        rightViewController?.removeFromParent()
        rightViewController?.view.removeFromSuperview()
    }
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
//            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
        setupViewControllers()
    }

    func setupViewControllers() {            
            
            let homeView = homeController.view!
            let menuView = menuController.view!
            homeView.translatesAutoresizingMaskIntoConstraints = false
            menuView.translatesAutoresizingMaskIntoConstraints = false
            
            redView.addSubview(homeView)
            redView.addSubview(darkCoverView)
            blueView.addSubview(menuView)
            
            NSLayoutConstraint.activate([
                // top, leading, bottom, trailing anchors
                homeView.topAnchor.constraint(equalTo: redView.topAnchor),
                homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
//
                menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
                menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
                menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
                menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),

                darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
                darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
                ])

            addChild(homeController)
            addChild(menuController)
    }

}

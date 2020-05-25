//
//  CardView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class CardView: UIView {
    let imageView = UIImageView(image: UIImage(named: "thor"))
    let threshold: CGFloat = 100
    let inforLabel = UILabel()
    var user: User? {
        didSet {
            imageView.image = UIImage(named: user?.imageName ?? "")
            inforLabel.text = "\(user?.name ?? "") \(user?.age ?? 0)\n \(user?.profession ?? "")\n\(user?.star ?? "")"
            if user?.jogging != true {
                jogging.alpha = 0
            }
            if user?.movie != true {
                movie.alpha = 0
            }
            if user?.afterNoonTea != true {
                afterNoonTea.alpha = 0
            }
            if user?.travel != true {
                travel.alpha = 0
            }
            if user?.chatFirst != true {
                chatFirst.alpha = 0
            }
            if user?.dinner != true {
                dinner.alpha = 0
            }
        }
    }
    let habbit = UIView()
    let jogging = UILabel()
    let movie = UILabel()
    let afterNoonTea = UILabel()
    let travel = UILabel()
    let chatFirst = UILabel()
    let dinner = UILabel()
    fileprivate func setupInfoLabelUI() {
        inforLabel.translatesAutoresizingMaskIntoConstraints = false
        inforLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        inforLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        inforLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        inforLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        inforLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inforLabel.numberOfLines = 0
        inforLabel.textColor = .white
        inforLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    fileprivate func setupCardPhotoUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(inforLabel)
        addSubview(habbit)
        setupCardPhotoUI()
        setupInfoLabelUI()
        setupHabbitUI()
        
        //add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    let topLabelStackView = UIStackView()
    let botLabelStackView = UIStackView()
    func setupHabbitUI() {
//        habbit.backgroundColor = .red
        habbit.translatesAutoresizingMaskIntoConstraints = false
        habbit.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        habbit.leadingAnchor.constraint(equalTo: inforLabel.trailingAnchor).isActive = true
        habbit.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        habbit.heightAnchor.constraint(equalToConstant: 100).isActive = true
        habbit.addSubview(topLabelStackView)
        habbit.addSubview(botLabelStackView)
        topLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        botLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        topLabelStackView.addArrangedSubview(jogging)
        topLabelStackView.addArrangedSubview(movie)
        topLabelStackView.addArrangedSubview(afterNoonTea)
        botLabelStackView.addArrangedSubview(travel)
        botLabelStackView.addArrangedSubview(chatFirst)
        botLabelStackView.addArrangedSubview(dinner)
        topLabelStackView.topAnchor.constraint(equalTo: habbit.topAnchor).isActive = true
        topLabelStackView.leadingAnchor.constraint(equalTo: habbit.leadingAnchor).isActive = true
        topLabelStackView.trailingAnchor.constraint(equalTo: habbit.trailingAnchor).isActive = true
        topLabelStackView.heightAnchor.constraint(equalToConstant: 50).isAccessibilityElement = true
        botLabelStackView.topAnchor.constraint(equalTo: topLabelStackView.bottomAnchor).isActive = true
        botLabelStackView.leadingAnchor.constraint(equalTo: habbit.leadingAnchor).isActive = true
        botLabelStackView.trailingAnchor.constraint(equalTo: habbit.trailingAnchor).isActive = true
        botLabelStackView.bottomAnchor.constraint(equalTo: habbit.bottomAnchor).isActive = true
        topLabelStackView.distribution = .fillEqually
        botLabelStackView.distribution = .fillEqually
        setupJogging()
        setupMovie()
        setupAfterNoonTea()
        setupTravel()
        setupChatFirst()
        setupDinner()
    }
    func setupJogging() {
        jogging.translatesAutoresizingMaskIntoConstraints = false
        jogging.text = "跑步"
        jogging.textColor = .white
        jogging.font = UIFont.boldSystemFont(ofSize: 24)
        jogging.textAlignment = .center
    }
    func setupMovie() {
        movie.translatesAutoresizingMaskIntoConstraints = false
        movie.text = "看電影"
        movie.textColor = .white
        movie.font = UIFont.boldSystemFont(ofSize: 24)
        movie.textAlignment = .center
    }
    func setupAfterNoonTea() {
        afterNoonTea.translatesAutoresizingMaskIntoConstraints = false
        afterNoonTea.text = "下午茶"
        afterNoonTea.textColor = .white
        afterNoonTea.font = UIFont.boldSystemFont(ofSize: 24)
        afterNoonTea.textAlignment = .center
    }
    func setupTravel() {
        travel.translatesAutoresizingMaskIntoConstraints = false
        travel.text = "去旅行"
        travel.textColor = .white
        travel.font = UIFont.boldSystemFont(ofSize: 24)
        travel.textAlignment = .center
    }
    func setupChatFirst() {
        chatFirst.translatesAutoresizingMaskIntoConstraints = false
        chatFirst.text = "先聊天"
        chatFirst.textColor = .white
        chatFirst.font = UIFont.boldSystemFont(ofSize: 24)
        chatFirst.textAlignment = .center
    }
    func setupDinner() {
        dinner.translatesAutoresizingMaskIntoConstraints = false
        dinner.text = "吃晚餐"
        dinner.textColor = .white
        dinner.font = UIFont.boldSystemFont(ofSize: 24)
        dinner.textAlignment = .center
    }
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        var upDismiss = false
        var downDismiss = false
        let translation = gesture.translation(in: self)
        upDismiss = translation.y * -1 > threshold ? true: false
        downDismiss = translation.y > threshold ? true: false
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            if upDismiss {
                self.transform = CGAffineTransform(translationX: 0, y: -1000)
            } else if downDismiss {
                self.transform = CGAffineTransform(translationX: 0, y: 1000)
            } else {
                self.transform = CGAffineTransform.identity
            }
        }) { (_) in
            gesture.setTranslation(.zero, in: self)
//            self.transform = .identity
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        //method 1
        //            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
        //            gesture.setTranslation(.zero, in: self)
        //method 2
        //            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        //method 3
        self.transform = CGAffineTransform.identity.translatedBy(x: translation.x, y: translation.y)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
            
        case .ended:
            handleEnded(gesture)
            
        default:
            break
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

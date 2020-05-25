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
    var cardViewModel: CardViewModel? {
        didSet {
            imageView.image = UIImage(named: cardViewModel?.imageName ?? "")
            inforLabel.attributedText = cardViewModel?.attributedString ?? NSAttributedString()
            inforLabel.textAlignment = cardViewModel?.textAlignment ?? NSTextAlignment.left
        }
    }
    fileprivate func setupInfoLabelUI() {
        inforLabel.translatesAutoresizingMaskIntoConstraints = false
        inforLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        inforLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        inforLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
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
        setupCardPhotoUI()
        setupInfoLabelUI()
        
        //add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
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

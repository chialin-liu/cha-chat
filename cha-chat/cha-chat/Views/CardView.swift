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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        //add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self)
            //method 1
//            self.center = CGPoint(x: self.center.x + translation.x, y: self.center.y + translation.y)
//            gesture.setTranslation(.zero, in: self)
            //method 2
//            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            //method 3
            self.transform = CGAffineTransform.identity.translatedBy(x: translation.x, y: translation.y)
            
        case .ended:
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform.identity
                
            }) { (_) in
                gesture.setTranslation(.zero, in: self)
            }
            
        default:
            ()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

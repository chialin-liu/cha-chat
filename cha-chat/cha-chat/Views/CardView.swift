//
//  CardView.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/24.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit

class CardView: UIView {
    let imageView = UIImageView(image: UIImage(systemName: "questionmark"))
    let threshold: CGFloat = 100
    let inforLabel = UILabel()
    let handLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "hand.point.left"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .bold)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        return button
    }()
    let handRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "hand.point.right"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .bold)
        button.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        return button
    }()
    var cardViewModel: CardViewModel? {
        didSet {
            imageView.image = UIImage(named: cardViewModel?.imageName.first ?? "questionmark")
            inforLabel.attributedText = cardViewModel?.attributedString ?? NSAttributedString()
            inforLabel.textAlignment = cardViewModel?.textAlignment ?? NSTextAlignment.left
            setupBarImageCount(cardViewModel: cardViewModel ?? CardViewModel(imageName: [], attributedString: NSAttributedString(), textAlignment: NSTextAlignment.left))
            if cardViewModel?.imageName.count ?? 0 > 1 {
                setupHandImageUI()
            } else {
                handLeftButton.alpha = 0
                handRightButton.alpha = 0
            }
        }
    }
    var imageIndex = 0
    func setupHandImageUI() {
        handRightButton.bottomAnchor.constraint(equalTo: inforLabel.topAnchor, constant: -40).isActive = true
        handRightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        handRightButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        handRightButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        handLeftButton.bottomAnchor.constraint(equalTo: inforLabel.topAnchor, constant: -40).isActive = true
        handLeftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        handLeftButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        handLeftButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        handRightButton.addTarget(self, action: #selector(handleRight), for: .touchUpInside)
        handLeftButton.addTarget(self, action: #selector(handleLeft), for: .touchUpInside)
    }
    @objc func handleRight() {
        if imageIndex != (cardViewModel?.imageName.count ?? 0) - 1 {
            imageIndex = imageIndex + 1
        }
        imageView.image = UIImage(named: cardViewModel?.imageName[imageIndex] ?? "questionmark")
        let totalCount = imageStackView.arrangedSubviews.count - 2
        for i in 0...totalCount {
            imageStackView.arrangedSubviews[i].backgroundColor = UIColor(white: 0, alpha: 0.1)
        }
        imageStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    @objc func handleLeft() {
        if imageIndex != 0{
            imageIndex = imageIndex - 1
        }
        imageView.image = UIImage(named: cardViewModel?.imageName[imageIndex] ?? "questionmark")
        let totalCount = imageStackView.arrangedSubviews.count - 2
        for i in 0...totalCount {
            imageStackView.arrangedSubviews[i].backgroundColor = UIColor(white: 0, alpha: 0.1)
        }
        imageStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    fileprivate func setupInfoLabelUI() {
        inforLabel.translatesAutoresizingMaskIntoConstraints = false
        inforLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        inforLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        inforLabel.bottomAnchor.constraint(equalTo: imageStackView.topAnchor).isActive = true
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
    func setupBarImageCount(cardViewModel: CardViewModel) {
        for _ in 1...cardViewModel.imageName.count {
            let dotView = UIView()
            dotView.translatesAutoresizingMaskIntoConstraints = false
            dotView.heightAnchor.constraint(equalToConstant: 4).isActive = true
            dotView.widthAnchor.constraint(equalToConstant: 4).isActive = true
            imageStackView.addArrangedSubview(dotView)
            dotView.backgroundColor = UIColor(white: 0, alpha: 0.1)
        }
        let blankRightView = UIView()
        imageStackView.addArrangedSubview(blankRightView)
        blankRightView.translatesAutoresizingMaskIntoConstraints = false
        blankRightView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        blankRightView.trailingAnchor.constraint(equalTo: imageStackView.trailingAnchor, constant: 10).isActive = true
//        blankRightView.backgroundColor = .red
        imageStackView.arrangedSubviews.first?.backgroundColor = .white
    }
    func setupImageBarLayout() {
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        imageStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        imageStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        imageStackView.spacing = 10
    }
    let imageStackView = UIStackView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        addSubview(inforLabel)
        addSubview(imageStackView)
        addSubview(handLeftButton)
        addSubview(handRightButton)
        setupCardPhotoUI()
        setupImageBarLayout()
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

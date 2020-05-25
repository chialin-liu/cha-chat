//
//  User.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/25.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
struct User {
    func toCardViewModel() -> CardViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "  \(age), \(star)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))

        attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        if jogging == true {
           attributedText.append(NSAttributedString(string: " 喜歡假日慢跑來認識你", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        }
        if movie == true {
           attributedText.append(NSAttributedString(string: " 喜歡透過看電影來認識你", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        }
        if food == true {
           attributedText.append(NSAttributedString(string: " 喜歡吃各種美食來認識你", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        }
        if chatFirst == true {
           attributedText.append(NSAttributedString(string: " 喜歡先透過聊天室來認識你", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        }
        if travel == true {
           attributedText.append(NSAttributedString(string: " 喜歡先透過輕旅行來認識你", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        }
        return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
    
    let name: String
    let age: Int
    let profession: String
    let imageName: String
    let jogging: Bool
    let movie: Bool
    let travel: Bool
    let chatFirst: Bool
    let food: Bool
    let star: String
}

//
//  RegisterViewModel.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/28.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
class RegisterViewModel {
//    var image: UIImage? {
//        didSet {
//            imageObserver?(image)
//            checkFormValidity()
//        }
//    }
//    var imageObserver: ((UIImage?) -> ())?
    var bindableImage = Bindable<UIImage>()
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? {
        didSet {
            checkFormValidity()
            
        }
    }
    var password: String? {
        didSet {
            checkFormValidity()
            
        }
    }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false && bindableImage.value != nil
//        isFormValidObserver?(isFormValid)
        bindableIsFormValid.value = isFormValid
        
    }
    
    // Reactive programming
//    var isFormValidObserver: ((Bool) -> ())?
    var bindableIsFormValid = Bindable<Bool>()
    
}


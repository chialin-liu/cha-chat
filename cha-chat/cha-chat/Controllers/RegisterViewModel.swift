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
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
    
}


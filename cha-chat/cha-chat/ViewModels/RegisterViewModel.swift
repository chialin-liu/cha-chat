//
//  RegisterViewModel.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/28.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
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
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if let err = err {
//                self.showLoadingHUD(error: err)
                completion(err)
                
            }
            self.saveImageToFirebase(completion: completion)
            
            
            if let user = res?.user {
                let uid = user.uid
                let email = user.email
                print("User info", uid, "email:", email ?? "")
            }
        }
    }
    func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid
        let docData = ["fullName": fullName ?? "", "uid": uid, "imageUrl": imageUrl]
        Firestore.firestore().collection("users").addDocument(data: docData) { (err) in
            if let err = err {
                completion(err)
                return
            }
            completion(nil)
        }
    }
    func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.9) ?? Data()
        ref.putData(imageData, metadata: nil) { (_, err) in
            if let err = err {
//                    self.showLoadingHUD(error: err)
                completion(err)
            }
            ref.downloadURL { (url, err) in
                if let err = err {
                    completion(err)
                }
                self.bindableIsRegistering.value = false
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                completion(nil)
            }
        }
    }
    // Reactive programming
//    var isFormValidObserver: ((Bool) -> ())?
    var bindableIsFormValid = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
}


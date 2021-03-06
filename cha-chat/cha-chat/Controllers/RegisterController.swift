//
//  RegisterController.swift
//  cha-chat
//
//  Created by Chialin Liu on 2020/5/28.
//  Copyright © 2020 Chialin Liu. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD
extension RegisterController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
//        registerViewMode.image = image
        registerViewMode.bindableImage.value = image
        dismiss(animated: true, completion: nil)
    }
}
class RegisterController: UIViewController {
    // UI Components
    let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 275).isActive = true
        button.widthAnchor.constraint(equalToConstant: 275).isActive = true
        button.layer.cornerRadius = 16
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    let fullNameTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let emailTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    let registerViewMode = RegisterViewModel()
    func setupRegisterViewModelObserver() {
        //fix issue retain cycle: unowned self
        registerViewMode.bindableIsFormValid.bind { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else { return }
            if isFormValid {
                self.registerButton.isEnabled = true
                self.registerButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1)
                self.registerButton.setTitleColor(.black, for: .normal)
            } else {
                self.registerButton.isEnabled = false
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .disabled)
            }
        }
//        registerViewMode.isFormValidObserver = { [unowned self](isFormValid) in
//            if isFormValid {
//                self.registerButton.isEnabled = true
//                self.registerButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1)
//                self.registerButton.setTitleColor(.black, for: .normal)
//            } else {
//                self.registerButton.isEnabled = false
//                self.registerButton.backgroundColor = .lightGray
//                self.registerButton.setTitleColor(.gray, for: .disabled)
//            }
//        }
        registerViewMode.bindableImage.bind { [unowned self] (image) in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
//        registerViewMode.imageObserver = { [unowned self] (image) in
//            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
            
//        }
        registerViewMode.bindableIsRegistering.bind { [unowned self] (isRegistering) in
            if isRegistering == true{
                self.registerHUD.textLabel.text = "Register"
                self.registerHUD.show(in: self.view)
            } else {
                self.registerHUD.dismiss()
            }
        }
    }
    @objc func handleTextChange(textField: UITextField) {
        if textField == fullNameTextField {
            registerViewMode.fullName = fullNameTextField.text
        } else if textField == emailTextField {
            registerViewMode.email = emailTextField.text
        } else {
            registerViewMode.password = passwordTextField.text
        }
        //without MVVM, registerViewModel
        
//        if fullNameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
//            registerButton.isEnabled = true
//            registerButton.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1)
//            registerButton.setTitleColor(.black, for: .normal)
//        } else {
//            registerButton.isEnabled = false
//            registerButton.backgroundColor = .lightGray
//            registerButton.setTitleColor(.gray, for: .disabled)
//        }
    }

    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        button.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 128/255, alpha: 1)
        //disable button
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        //
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    @objc func handleRegister() {
        handleTap()
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//        registerViewMode.bindableIsRegistering.value = true
        registerViewMode.performRegistration { [weak self] (err) in
            if let err = err {
                self?.showLoadingHUD(error: err)
                return
            }
        }

    }
    let registerHUD = JGProgressHUD(style: .dark)
    func showLoadingHUD(error: Error) {
        registerHUD.dismiss()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Register Error"
        hud.detailTextLabel.text = error.localizedDescription
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3, animated: true)
        
    }
    lazy var verticalStackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
       ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    lazy var stackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
    ])
    fileprivate func setupStackView() {
        stackView.axis = .vertical
        
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        //        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradientLayer()
        view.backgroundColor = .red
        view.addSubview(stackView)
        setupStackView()
        setupNotificationObservers()
        tapGesture()
        setupRegisterViewModelObserver()
    }
    //close the keyboard when tapping
    func tapGesture() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    @objc func handleTap() {
        view.endEditing(true)
        view.transform = .identity
    }
    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //resolve: retain cycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self) // you'll have a retain cycle
    }
    @objc fileprivate func handleKeyboardHide() {
        self.view.transform = .identity
    }
    @objc fileprivate func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - stackView.frame.origin.y - stackView.frame.height
//        print(bottomSpace)
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    fileprivate func setupGradientLayer() {
        
        let topColor = UIColor(red: 80/255, green: 200/255, blue: 120/255, alpha: 1)
        let bottomColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        
    }
    //fix issue: register autolayout #3
    let gradientLayer = CAGradientLayer()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    //fix issue: #4
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
}

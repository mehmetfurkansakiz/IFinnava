//
//  LoginViewController.swift
//  IFinnava
//
//  Created by furkan sakız on 24.07.2024.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    private let titleLabel: UILabel = .init()
    private let emailTextField: UITextField = .init()
    private let passwordTextField: UITextField = .init()
    private let loginButton: UIButton = .init(type: .system)
    private let rememberMeButton: UIButton = .init(type: .system)
    var isRememberMeChecked = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(rememberMeButton)

        view.backgroundColor = .white
        
        // Title Label
        titleLabel.text = "Login IFinnava"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)

        // Email TextField
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter your email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1

        // Password TextField
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1

        // Remember Me Button
        rememberMeButton.setTitle("Remember Me ☐", for: .normal)
        rememberMeButton.setTitleColor(.black, for: .normal)
        rememberMeButton.addTarget(self, action: #selector(rememberMeButtonTapped), for: .touchUpInside)
        
        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    func setupConstraints() {

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        rememberMeButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(rememberMeButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    @objc func loginButtonTapped() {
        let email = emailTextField.text ?? ""

        if isRememberMeChecked {
            UserDefaults.standard.set(email, forKey: "email")
        } else {
            UserDefaults.standard.removeObject(forKey: "email")
        }
    }

    @objc func rememberMeButtonTapped() {
        isRememberMeChecked.toggle()
        let checkboxTitle = isRememberMeChecked ? "Remember Me ☑️" : "Remember Me ☐"
        rememberMeButton.setTitle(checkboxTitle, for: .normal)
    }
}
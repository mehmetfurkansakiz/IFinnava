//
//  LoginViewController.swift
//  IFinnava
//
//  Created by furkan sakız on 24.07.2024.
//

import FirebaseAuth
import SnapKit
import UIKit

class LoginViewController: UIViewController {
    private let titleLabel: UILabel = .init()
    private let emailTextField: UITextField = .init()
    private let passwordTextField: UITextField = .init()
    private let loginButton: UIButton = .init(type: .system)
    private let rememberMeButton: UIButton = .init(type: .system)
    private let registerRedirectButton: UIButton = .init(type: .system)
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
        view.addSubview(registerRedirectButton)

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

        // Register Redirect Button
        registerRedirectButton.setTitle("Don't have an account? Register", for: .normal)
        registerRedirectButton.setTitleColor(.black, for: .normal)
        registerRedirectButton.addTarget(self, action: #selector(registerRedirectButtonTapped), for: .touchUpInside)
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

        registerRedirectButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    @objc func loginButtonTapped() {
        let email = emailTextField.text
        let password = passwordTextField.text

        if email != "" && password != "" {
            Auth.auth().signIn(withEmail: email!, password: password!) { authResult, error in
                if let error = error {
                    print("Giriş hatası: \(error.localizedDescription)")
                    AlertHelper.basicAlert(title: "Error", message: error.localizedDescription, in: self)
                } else {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    print("Kullanıcı giriş yaptı. UID: \(authResult?.user.uid ?? "")")

                    if self.isRememberMeChecked {
                        UserDefaults.standard.set(email, forKey: "email")
                    } else {
                        UserDefaults.standard.removeObject(forKey: "email")
                    }
                    
                    let homeViewController = HomeViewController()
                    homeViewController.modalPresentationStyle = .fullScreen
                    self.present(homeViewController, animated: true, completion: nil)
                }
            }
        } else {
            AlertHelper.basicAlert(title: "Error", message: "Email/Password cannot be empty", in: self)
        }
    }

    @objc func rememberMeButtonTapped() {
        isRememberMeChecked.toggle()
        let checkboxTitle = isRememberMeChecked ? "Remember Me ☑️" : "Remember Me ☐"
        rememberMeButton.setTitle(checkboxTitle, for: .normal)
    }

    @objc func registerRedirectButtonTapped() {
        let registerViewController = RegisterViewController()
        registerViewController.modalPresentationStyle = .fullScreen
        present(registerViewController, animated: true, completion: nil)
    }
}

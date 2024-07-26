//
//  RegisterViewController.swift
//  IFinnava
//
//  Created by furkan sakız on 25.07.2024.
//

import SnapKit
import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    private let titleLabel: UILabel = .init()
    private let emailTextField: UITextField = .init()
    private let passwordTextField: UITextField = .init()
    private let rePasswordTextField: UITextField = .init()
    private let registerButton: UIButton = .init(type: .system)
    private let loginRedirectButton: UIButton = .init(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginRedirectButton)

        view.backgroundColor = .white

        // Title Label
        titleLabel.text = "Register IFinnava"
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

        // Re Password TextField
        rePasswordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your password again", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        rePasswordTextField.isSecureTextEntry = true
        rePasswordTextField.borderStyle = .roundedRect
        rePasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        rePasswordTextField.layer.borderWidth = 1

        // Register Button
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.backgroundColor = .black
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

        // Login Redirect Button
        loginRedirectButton.setTitle("Already have an account? Log In", for: .normal)
        loginRedirectButton.setTitleColor(.black, for: .normal)
        loginRedirectButton.addTarget(self, action: #selector(loginRedirectButtonTapped), for: .touchUpInside)
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

        rePasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalTo(rePasswordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        loginRedirectButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }

    @objc func registerButtonTapped() {
        let email = emailTextField.text
        let password = passwordTextField.text
        let rePassword = rePasswordTextField.text
        
        if email != "" && password != "" && rePassword != "" {
            if password == rePassword {
                Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
                    if let error = error {
                            AlertHelper.basicAlert(title: "Error", message: error.localizedDescription, in: self)
                        } else {
                            print("User Registered. UID: \(authResult?.user.uid ?? "")")
                            let homeViewController = HomeViewController()
                            homeViewController.modalPresentationStyle = .fullScreen
                            self.present(homeViewController, animated: true, completion: nil)
                        }
                }
            } else {
                AlertHelper.basicAlert(title: "Error", message: "Passwords do NOT match", in: self)
                
            }
        } else {
            AlertHelper.basicAlert(title: "Error", message: "Email/Password cannot be empty", in: self)
        }
    }
    
    @objc func loginRedirectButtonTapped() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
}

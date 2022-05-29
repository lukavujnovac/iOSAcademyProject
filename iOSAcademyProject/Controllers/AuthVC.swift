//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 21.05.2022..
//

import UIKit
import FirebaseAuth
import SnapKit
import SwiftUI

class AuthVC: UIViewController {
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Adress"
        emailField.autocapitalizationType = .none
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        emailField.layer.cornerRadius = 10
        emailField.autocorrectionType = .no
        
        return emailField
    }() 
    
    private let passwordField: UITextField = {
        let passwordField = UITextField()
        passwordField.placeholder = "Password"
        passwordField.layer.borderWidth = 1
        passwordField.isSecureTextEntry = true
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.backgroundColor = .white
        passwordField.leftViewMode = .always
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 18, height: 0))
        passwordField.layer.cornerRadius = 10
        passwordField.autocorrectionType = .no
        
        return passwordField
    }() 
    
    lazy private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }() 
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureButton() 
        assignbackground()
        
        self.tabBarController?.tabBar.isHidden = true
        
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
    }
    
    private func assignbackground(){
        let background = UIImage(named: "nba")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        imageView.makeBlurImage(targetImageView: imageView)
    }
    
    private func configureButton() {
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        configureLabelConstraints()
        configureEmailFieldConstraints()
        configurePasswordFieldConstraints()
        configureButtonConstraints()
    }
    
    private func addViews() {
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
    }
    
    func finishLoggingIn() {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let rootVC = appDelegate.window?.rootViewController 
        guard let mainNavigationController = rootVC as? MainNavigationController else {return}
        
        mainNavigationController.viewControllers = [FavouritesViewController()]
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        dismiss(animated: true)
    }
    
    @objc private func didTapButton() {
        print("tap")
        guard let email = emailField.text, !email.isEmpty, 
                let password = passwordField.text, !password.isEmpty  else {
            
            print("missing field data, password must be atleast 6 characters long")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {return}
            guard error == nil else {
                //show account creation 
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            print("you have signed in")
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
            
            UserDefaults.standard.setIsLoggedIn(value: true)
            
            let vc = FavouritesViewController()
            let navigationController = UINavigationController(rootViewController: vc)
            vc.navigationController?.navigationBar.barStyle = .default
            navigationController.modalPresentationStyle = .fullScreen
            strongSelf.present(navigationController, animated: true)
            
            strongSelf.finishLoggingIn()
        }
        
    }
    
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else {return}
                guard error == nil else {
                    print("account creation failed")
                    return
                }
                
                print("you have signed in")
                
                strongSelf.emailField.resignFirstResponder()
                strongSelf.passwordField.resignFirstResponder()
                
                let vc = FavouritesViewController()
                strongSelf.navigationController?.pushViewController(vc, animated: true)
                
                UserDefaults.standard.setIsLoggedIn(value: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    } 
}

private extension AuthVC {
    func configureLabelConstraints() {
        label.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    func configureEmailFieldConstraints() {
        emailField.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    func configurePasswordFieldConstraints() {
        passwordField.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    func configureButtonConstraints() {
        
        button.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordField.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
}

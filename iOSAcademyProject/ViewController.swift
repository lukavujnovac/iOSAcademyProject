//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 21.05.2022..
//

import UIKit
import FirebaseAuth
import SnapKit

class ViewController: UIViewController {
    
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Adress"
        emailField.autocapitalizationType = .none
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
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
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return passwordField
    }() 
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        
        return button
    }() 
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }() 
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        
        return button
    }() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureButton() 
        assignbackground()
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            view.backgroundColor = .systemBlue
            label.isHidden = true
            button.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            
            signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
        
        configureConstraints()
    }
    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            label.isHidden = false
            button.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            
            signOutButton.removeFromSuperview()
        }catch{
            print("An error occured signin out")
        }
    }
    
    func assignbackground(){
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
        label.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
        
        passwordField.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(emailField.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
        
        button.snp.makeConstraints { 
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordField.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(50)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
    }
    
    private func addViews() {
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signOutButton)
    }
    
    @objc private func didTapButton() {
        print("tap")
        guard let email = emailField.text, !email.isEmpty, 
                let password = passwordField.text, !password.isEmpty  else {
            
            print("missing field data")
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
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
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
                strongSelf.label.isHidden = true
                strongSelf.emailField.isHidden = true
                strongSelf.passwordField.isHidden = true
                strongSelf.button.isHidden = true
                
                strongSelf.emailField.resignFirstResponder()
                strongSelf.passwordField.resignFirstResponder()
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            
        }))
        
        present(alert, animated: true)
    } 
}

extension UIImageView
{
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
}

//
//  WelcomeVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 23.05.2022..
//

import UIKit
import SnapKit

class WelcomeVC: UIViewController {
    
    private let nbaLogoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "assetsExportableLogosNbaNbaFullNegative")
        
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover all about NBA"
        label.font = UIFont.systemFont(ofSize: 50, weight: .regular)
        label.numberOfLines = 2
        label.textColor = .systemBackground
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search players and teams to get all the inside stats"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .systemBackground
        
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.white, for: .normal)
        button.setTitle("TRY WITHOUT AN ACCOUNT", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureConstraints()
        assignbackground()
        configureLogInButton()
        configureSkipButton()
        view.backgroundColor = .systemBlue
    }
    
    private func addViews() {
        view.addSubview(nbaLogoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(signInButton)
        view.addSubview(skipButton)
    }
    
    private func configureLogInButton() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        let authVC = AuthVC()
        authVC.modalPresentationStyle = .formSheet
        present(authVC, animated: true) 
//        self.navigationController?.pushViewController(authVC, animated: true)
    }
    
    private func configureSkipButton() {
        skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
    }
    
    @objc func didTapSkip() {
        UserDefaults.standard.setIsLoggedIn(value: true)
        let homeVC = MainNavigationController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true)
    }
    
    private func configureConstraints() {
        configureNbaLogoImageViewConstraints()
        configureTitleConstraints()
        configureSubtitleConstraints()
        configureSignInButtonConstraints()
        configureSkipButtonConstraints()
    }
    
}

private extension WelcomeVC {
    func configureSkipButtonConstraints() {
        skipButton.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(48)
            $0.top.equalTo(signInButton.snp.bottom).offset(16)
            $0.height.equalTo(36)
            $0.width.equalTo(280)
        }
    }
    
    func configureSignInButtonConstraints() {
        signInButton.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(48)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(260)
            $0.height.equalTo(36)
            $0.width.equalTo(280)
        }
    }
    
    func configureSubtitleConstraints() {
        subtitleLabel.snp.makeConstraints { 
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-66)
        }
    }
    
    func configureTitleConstraints() {
        titleLabel.snp.makeConstraints {       
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-66)
            $0.top.equalTo(nbaLogoImageView.snp.bottom).offset(56)
        }
    }
    
    func configureNbaLogoImageViewConstraints() {
        nbaLogoImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(80)
            $0.width.equalTo(138)
        }
    }
}

private extension WelcomeVC {
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
}

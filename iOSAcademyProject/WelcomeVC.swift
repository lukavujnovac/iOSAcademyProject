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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        configureConstraints()
        assignbackground()
        configureLogInButton()
        view.backgroundColor = .systemBlue
    }
    
    private func addViews() {
        view.addSubview(nbaLogoImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(signInButton)
    }
    
    private func configureLogInButton() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    @objc func didTapSignIn() {
        let authVC = AuthVC()
        
        self.navigationController?.pushViewController(authVC, animated: true)
    }
    
    private func configureConstraints() {
        nbaLogoImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalToSuperview().offset(100)
            $0.height.equalTo(80)
            $0.width.equalTo(138)
        }
        
        titleLabel.snp.makeConstraints {       
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-66)
            $0.top.equalTo(nbaLogoImageView.snp.bottom).offset(56)
        }
        
        subtitleLabel.snp.makeConstraints { 
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-66)
        }
        
        signInButton.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(48)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(260)
            $0.height.equalTo(36)
            $0.width.equalTo(280)
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
}

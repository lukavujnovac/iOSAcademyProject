//
//  AboutVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 07.06.2022..
//

import UIKit

class AboutVC: UIViewController {

    private let firstLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "SofaScore Academy"
        label.tintColor = .label
        
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "Class 2022"
        label.tintColor = .label
        
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sofaAbout")
        iv.layer.cornerRadius = 10
        
        return iv
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "APP NAME"
        label.tintColor = .label
        
        return label
    }()
    
    private let nbaAppLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "APP NAME"
        label.tintColor = .label
        
        return label
    }()
    
    private let apiCreditLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "API CREDIT"
        label.tintColor = .label
        
        return label
    }()
    
    private let balldontlieLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "balldontlie"
        label.tintColor = .label
        
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "DEVELOPER"
        label.tintColor = .label
        
        return label
    }()
    
    private let lukaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Luka Vujnovac"
        label.tintColor = .label
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "About"
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(imageView)
        view.addSubview(appNameLabel)
        view.addSubview(nbaAppLabel)
        view.addSubview(apiCreditLabel)
        view.addSubview(balldontlieLabel)
        view.addSubview(developerLabel)
        view.addSubview(lukaLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    private func configureConstraints() {
        firstLabel.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(18)
        }
        
        secondLabel.snp.makeConstraints { 
            $0.top.equalTo(firstLabel.snp.bottom).offset(9)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        imageView.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview().inset(36)
            $0.top.equalTo(secondLabel.snp.bottom).offset(9)
            $0.height.equalTo(80)
        }
        
        appNameLabel.snp.makeConstraints { 
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        nbaAppLabel.snp.makeConstraints { 
            $0.top.equalTo(appNameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        apiCreditLabel.snp.makeConstraints { 
            $0.top.equalTo(nbaAppLabel.snp.bottom).offset(20)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        balldontlieLabel.snp.makeConstraints { 
            $0.top.equalTo(apiCreditLabel.snp.bottom).offset(8)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        developerLabel.snp.makeConstraints { 
            $0.top.equalTo(balldontlieLabel.snp.bottom).offset(20)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
        
        lukaLabel.snp.makeConstraints { 
            $0.top.equalTo(developerLabel.snp.bottom).offset(8)
            $0.leading.equalTo(firstLabel.snp.leading)
        }
    }
}

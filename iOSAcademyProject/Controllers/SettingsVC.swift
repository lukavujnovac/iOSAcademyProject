//
//  SettingsVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 07.06.2022..
//

import UIKit

class SettingsVC: UIViewController {
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Vestibulum rutrum quam vitae fringilla tincidunt. Suspendisse nec tortor urna."
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        
        return label
    }()
    
    private let aboutButton: UIButton = {
        let button = UIButton()
        button.setTitle("More Info", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.tintColor = .systemBackground
        button.addTarget(self, action: #selector(didTapAbout), for: .touchUpInside)
        
        return button
    }()
    
    private let clearButton: UIButton = {
            let button = UIButton()
            button.setTitle("CLEAR MY FAVORITES LIST", for: .normal)
            button.setTitleColor(.systemRed, for: .normal)
            button.layer.cornerRadius = 7
            button.tintColor = .systemBackground
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemRed.cgColor
            button.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
            
            return button 
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    @objc private func didTapAbout() {
        print("navigate to about scr")
        let vc = AboutVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapClear() {
        CoreDataManager.shared.deleteAllTeams(in: "TeamEntity")
        print("delete all teams")
    }
    
    private func addSubviews() {
        view.addSubview(aboutLabel)
        view.addSubview(detailLabel)
        view.addSubview(aboutButton)
        view.addSubview(clearButton)
    }
    
    private func configureConstraints() {
        detailLabel.snp.makeConstraints { 
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.top.equalTo(aboutLabel.snp.bottom).offset(8)
        }
        
        aboutLabel.snp.makeConstraints { 
            $0.centerY.equalToSuperview().offset(-150)
            $0.leading.equalToSuperview().offset(18)
        }
        
        aboutButton.snp.makeConstraints { 
            $0.leading.equalTo(aboutLabel.snp.leading)
            $0.top.equalTo(detailLabel.snp.bottom).offset(10)
        }
        
        clearButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.top.equalTo(aboutButton.snp.bottom).offset(50)
        }
    }
}

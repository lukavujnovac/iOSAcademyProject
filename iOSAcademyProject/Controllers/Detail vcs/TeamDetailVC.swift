//
//  PlayerDetailVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import UIKit
import SnapKit
import SwiftUI

class TeamDetailVC: UIViewController {
    private let teamImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemBlue
        
        return iv
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private let conferenceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()
    
    private let divisionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        
        return label
    }()
    
    private let gamesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show games", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 7
        button.tintColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return button
    }()
    
    let viewModel: TeamViewModel
    var conferenceTeams = [Team]()
    var teams = [Team]()
    
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.fullName
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configure(with: viewModel)
        print(viewModel.imageString)
    }
    
    @objc func didTapButton() {
        print("show games for \(viewModel.id)")
        
        let vc = GamesVC(team: viewModel.id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func filterConference() {
        conferenceTeams = teams.filter({$0.conference == viewModel.conference})
        print("conference teams: \(conferenceTeams.count)")
    }
    
    
    private func addSubviews() {
        view.addSubview(teamImageView)
        view.addSubview(teamNameLabel)
        view.addSubview(divisionLabel)
        view.addSubview(locationLabel)
        view.addSubview(conferenceLabel)
        view.addSubview(gamesButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ApiCaller.shared.getTeams { [weak self] result in
            switch result {
                case .success(let teams):
                    self?.teams = teams
                    self?.filterConference()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func configure(with viewModel: TeamViewModel) {
        teamImageView.image = UIImage(named: viewModel.imageString.lowercased())
        teamNameLabel.text = viewModel.fullName
        divisionLabel.text = "\(viewModel.division) Division"
        locationLabel.text = "Location: \(viewModel.city)"
        conferenceLabel.text = "\(viewModel.conference) Conference"
    }
    
    private func configureConstraints() {
        teamImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(110)
            $0.width.height.equalTo(80)
        }
        
        teamNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(teamImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().offset(110)
        }
        
        locationLabel.snp.makeConstraints { 
            $0.leading.equalTo(teamImageView.snp.trailing).offset(16)
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(36)
        }
        
        conferenceLabel.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalTo(teamImageView.snp.bottom).offset(28)
        }
        
        divisionLabel.snp.makeConstraints { 
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalTo(teamImageView.snp.bottom).offset(28)
        }
        
        gamesButton.snp.makeConstraints { 
            $0.top.equalTo(divisionLabel.snp.bottom).offset(40)
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
        }
    }
}

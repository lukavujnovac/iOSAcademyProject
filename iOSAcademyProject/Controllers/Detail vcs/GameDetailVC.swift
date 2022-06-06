//
//  GameDetailVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//

import UIKit

class GameDetailVC: UIViewController {
    
    private let homeTeamImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    private let visitorTeamImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        label.tintColor = .systemGray
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    let viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Match info"
        view.backgroundColor = .systemBackground
        addSubviews()
        configure()
        
        print("\(viewModel.homeTeam.name) vs \(viewModel.visitorTeam.name)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureConstraints()
    }
    
    private func configure() {
        homeTeamImageView.image = UIImage(named: viewModel.homeTeam.name?.lowercased() ?? "")
        visitorTeamImageView.image = UIImage(named: viewModel.visitorTeam.name?.lowercased() ?? "")
        scoreLabel.text = "\(viewModel.homeTeamScore) - \(viewModel.visitorTeamScore)"
        statusLabel.text = viewModel.status
        
        var date = viewModel.date
        date = date.components(separatedBy: "T")[0]
        dateLabel.text = date
        
    }
    
    private func addSubviews() {
        view.addSubview(homeTeamImageView)
        view.addSubview(visitorTeamImageView)
        view.addSubview(scoreLabel)
        view.addSubview(statusLabel)
        view.addSubview(dateLabel)
    }
    
    private func configureConstraints() {
        homeTeamImageView.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(64)
        }
        
        visitorTeamImageView.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.height.equalTo(64)
        }
        
        scoreLabel.snp.makeConstraints { 
            $0.top.equalTo(homeTeamImageView.snp.centerY)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(scoreLabel.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        statusLabel.snp.makeConstraints { 
            $0.top.equalTo(scoreLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

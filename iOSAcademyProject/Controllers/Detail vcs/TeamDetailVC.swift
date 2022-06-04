//
//  PlayerDetailVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import UIKit
import SnapKit

class TeamViewModel {
    let fullName: String
    let id: Int
    let abbreviation: String
    let city: String
    let division: String
    let imageString: String
    let conference: String
    let name: String
    
    init(fullName: String, id: Int, abbreviation: String, city: String, division: String, imageString: String, conference: String, name: String) {
        self.fullName = fullName
        self.id = id
        self.abbreviation = abbreviation
        self.city = city
        self.division = division
        self.imageString = imageString
        self.conference = conference
        self.name = name
    }
}

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
    
    func filterConference() {
        conferenceTeams = teams.filter({$0.conference == viewModel.conference})
        print("conference teams: \(conferenceTeams.count)")
    }
    
    
    private func addSubviews() {
        view.addSubview(teamImageView)
        view.addSubview(teamNameLabel)
        view.addSubview(divisionLabel)
        view.addSubview(locationLabel)
        view.addSubview(conferenceLabel)
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
    
    func configure(with viewModel: TeamViewModel) {
        teamImageView.image = UIImage(named: viewModel.imageString.lowercased())
        teamNameLabel.text = viewModel.fullName
        divisionLabel.text = "\(viewModel.division) Division"
        locationLabel.text = "Location: \(viewModel.city)"
        conferenceLabel.text = "\(viewModel.conference) Conference"
    }
    
    func configureConstraints() {
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
    }
}
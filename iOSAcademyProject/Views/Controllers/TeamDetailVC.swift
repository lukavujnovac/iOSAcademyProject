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
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let conferenceLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let divisionLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let viewModel: TeamViewModel
    
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Player"
        view.backgroundColor = .systemBackground
        
        addSubviews()
        configureConstraints()
        configure(with: viewModel)
        
        ApiCaller.shared.getTeam(id: 12) { result in
            switch result {
                case .success(let response):
                    break
                case .failure(let error):
                    print(error)
            }
        }
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
        
    }
    
    func configure(with viewModel: TeamViewModel) {
        teamImageView.image = UIImage(named: viewModel.name)
        teamNameLabel.text = viewModel.fullName
        divisionLabel.text = viewModel.division
        locationLabel.text = viewModel.city
        conferenceLabel.text = viewModel.conference
    }
    
    func configureConstraints() {
        teamNameLabel.snp.makeConstraints { 
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

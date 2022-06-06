//
//  GameCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//

import UIKit
import SnapKit
import SwiftUI

class GameViewModel {
    let id: Int
    let date: String
    let homeTeamScore: Int
    let visitorTeamScore: Int
    let season: Int
    let period: Int
    let status: String
    let time: String
    let postseason: Bool
    let homeTeam: Team
    let visitorTeam: Team
    
    init(id: Int, date: String, homeTeamScore: Int, visitorTeamScore: Int, season: Int, period: Int, status: String, time: String, postseason: Bool, homeTeam: Team, visitorTeam: Team) {
        self.id = id
        self.date = date
        self.homeTeamScore = homeTeamScore
        self.visitorTeamScore = visitorTeamScore
        self.season = season
        self.period = period
        self.status = status
        self.time = time
        self.postseason = postseason
        self.homeTeam = homeTeam
        self.visitorTeam = visitorTeam
    }
}

class GameCell: UITableViewCell {
    static let identifier: String = "GameCell"
    
    private let homeTeamImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let visitorTeamImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(homeTeamImageView)
        contentView.addSubview(visitorTeamImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configure(with viewModel: GameViewModel) {
        
        homeTeamImageView.image = UIImage(named: viewModel.homeTeam.name?.lowercased() ?? "")
        visitorTeamImageView.image = UIImage(named: viewModel.visitorTeam.name?.lowercased() ?? "")
        scoreLabel.text = "\(viewModel.homeTeamScore) - \(viewModel.visitorTeamScore)"
        var date = viewModel.date
        date = date.components(separatedBy: "T")[0]
        
        dateLabel.text = date
    }
    
    private func configureConstraints() {
        homeTeamImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(64)
        }
        
        visitorTeamImageView.snp.makeConstraints { 
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.height.equalTo(64)
        }
        
        scoreLabel.snp.makeConstraints { 
            $0.top.equalTo(homeTeamImageView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(scoreLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

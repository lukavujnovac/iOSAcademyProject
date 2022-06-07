//
//  GameCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//

import UIKit
import SnapKit
import SwiftUI

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
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        
        return label
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(homeTeamImageView)
        contentView.addSubview(visitorTeamImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(statusLabel)
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
        statusLabel.text = viewModel.status
        
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

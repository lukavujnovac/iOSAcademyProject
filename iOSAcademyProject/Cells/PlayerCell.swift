//
//  PlayerCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 02.06.2022..
//

import UIKit
import SnapKit

class PlayerCell: UITableViewCell {
    static let identifier = "PlayerCell"
    
    var lastNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    var firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    var teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    var playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(teamNameLabel)
        contentView.addSubview(playerImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerImageView.image = nil
        firstNameLabel.text = nil
        lastNameLabel.text = nil
        teamNameLabel.text = nil
    }
    
    func configure(with viewModel: PlayerViewModel) {
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        teamNameLabel.text = viewModel.team.name
        playerImageView.image = UIImage(named: viewModel.position)
        playerImageView.backgroundColor = .systemBlue
    }
    
    private func configureConstraints() {
        playerImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(18)
            $0.width.height.equalTo(120)
        }
        
        firstNameLabel.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(170)
            $0.top.equalToSuperview().offset(5)
        }
        
        lastNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(firstNameLabel.snp.trailing).offset(5)
            $0.top.equalToSuperview().offset(5)
        }
        
        teamNameLabel.snp.makeConstraints { 
            $0.leading.equalToSuperview().offset(170)
            $0.top.equalTo(firstNameLabel.snp.bottom).offset(5)
        }
    }
}

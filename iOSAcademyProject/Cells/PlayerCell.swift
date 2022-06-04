//
//  PlayerCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 02.06.2022..
//

import UIKit
import SnapKit

class PlayerViewModel {
    let id: Int
    let firstName: String
    let lastName: String
    let heightFeet: Int
    let heightInches: Int
    let position: String
    let team: Team
    let weightPounds: Int
    
    init(id: Int, firstName: String, lastName: String, heightFeet: Int, heightInches: Int, position: String, team: Team, weightPounds: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.heightFeet = heightFeet
        self.heightInches = heightInches
        self.position = position
        self.team = team
        self.weightPounds = weightPounds
    }
}

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
    
    private let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
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
//        playerImageView.image = nil
    }
    
    func configure(with viewModel: PlayerViewModel) {
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        teamNameLabel.text = viewModel.team.name
        imageView?.image = UIImage(named: viewModel.team.name?.lowercased() ?? "")
        imageView?.backgroundColor = .systemBlue
        

//        let urlString = "\(ApiCaller.Constants.playerImageURL)\(viewModel.id)"
//        guard let url = URL(string: urlString) else {return}
        
//        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
//            guard let data = data, error == nil else {return}
//            DispatchQueue.main.async {
//                let image = UIImage(data: data)
////                self?.playerImageView.image = UIImage(systemName: "")
//                self?.playerImageView.image = image
//            }
//        }
//        task.resume()
        
//        if let data = viewModel.imageData {
//            playerImageView.image = UIImage(data: data)
//        }else {
//            let urlString = viewModel.imageUrl
//            if let url = urlString {
//                URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
//                    guard let data = data, error == nil else {return}
//                    viewModel.imageData = data
//                    DispatchQueue.main.async {
//                        self?.playerImageView.image = UIImage(data: data)
//                    }
//                }.resume()
//            }
//        }
    }
    
    private func configureConstraints() {
        playerImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(30)
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

//
//  PlayerCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 02.06.2022..
//

import UIKit
import SnapKit

class PlayerCellViewModel {
    let firstName: String
    let lastName: String
    let teamName: String
    var imageUrl: URL? = nil
    var imageData: Data? = nil
    let id: Int
    
    init(firstName: String, lastName: String, teamName: String, imageUrl: URL?, id: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.teamName = teamName
        let urlString = "\(ApiCaller.Constants.playerImageURL ?? "")\(id)"
        self.imageUrl = URL(string: urlString)
        self.id = id
    }
}

class PlayerCell: UITableViewCell {
    static let identifier = "PlayerCell"
    
    private let lastNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    private let teamNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemBlue
        iv.contentMode = .scaleAspectFill
        
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
    }
    
    func configure(with viewModel: PlayerCellViewModel) {
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        teamNameLabel.text = viewModel.teamName
        
        if let data = viewModel.imageData {
            playerImageView.image = UIImage(data: data)
        }else {
            let urlString = URL(string: "\(ApiCaller.Constants.playerImageURL)\(viewModel.id)")
            if let url = urlString {
                URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                    guard let data = data, error == nil else {return}
                    viewModel.imageData = data
                    DispatchQueue.main.async {
                        self?.playerImageView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
    private func configureConstraints() {
        playerImageView.snp.makeConstraints { 
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        firstNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(playerImageView.snp.trailing).offset(30)
            $0.top.equalToSuperview().offset(5)
        }
        
        lastNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(firstNameLabel.snp.trailing).offset(5)
            $0.top.equalToSuperview().offset(5)
        }
        
        teamNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(playerImageView.snp.trailing).offset(50)
            $0.top.equalTo(firstNameLabel.snp.bottom).offset(5)
        }
    }
}

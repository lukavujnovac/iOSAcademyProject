//
//  TeamCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 31.05.2022..
//

import UIKit

class TeamCellViewModel {
    let fullName: String
    let id: Int
    let imageString: String
    let conference: String
    
    init(fullName: String, imageName: String, id: Int, conference: String) {
        self.fullName = fullName
        self.imageString = imageName
        self.id = id
        self.conference = conference
    }
}

class TeamCell: UITableViewCell {
    static let identifier = "TeamCell"
    
    var teamLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        return label
    }()
    
    var teamImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(teamImage)
        contentView.addSubview(teamLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamLabel.frame = CGRect(x: contentView.frame.size.width / 2 - 50, y: 0, width: contentView.frame.size.width - 120, height: contentView.frame.size.height / 2)
        
        teamImage.frame = CGRect(x: 18, y: 5, width: 70, height: contentView.frame.size.height - 10)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        teamLabel.text = nil
        teamImage.image = nil
    }
    
    func configure(with viewModel: TeamCellViewModel) {
        teamLabel.text = viewModel.fullName
        teamImage.image = UIImage(named: viewModel.imageString)
    }
    
}

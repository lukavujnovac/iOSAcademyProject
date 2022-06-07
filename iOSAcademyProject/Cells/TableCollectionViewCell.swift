//
//  TableCollectionViewCell.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 26.05.2022..
//

import UIKit

class TableCollectionViewCell: UICollectionViewCell {
    static let identifier = "TableCollectionViewCell"
    
    private let myImageView: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.size.width-16, height: contentView.frame.size.height-5)
    }
    
    public func configure(with model: CollectionTableCellModel) {
        myImageView.image = UIImage(named: model.imageName)
    }
}

//
//  EmptyView.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import UIKit
import SnapKit

class EmptyView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.text = "No results found"
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    func layout() {
        layoutLabel()
    }
    
    
    func layoutLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 224, height: 32)
        label.center = self.center
    }
}

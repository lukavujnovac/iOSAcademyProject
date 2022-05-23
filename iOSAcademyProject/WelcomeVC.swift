//
//  WelcomeVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 23.05.2022..
//

import UIKit
import SnapKit

class WelcomeVC: UIViewController {

    private let nbaLogoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "assetsExportableLogosNbaNbaFullNegative")
        iv.sizeToFit()
        
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        view.addSubview(nbaLogoImageView)
        
        nbaLogoImageView.frame = CGRect(x: 0, y: 10, width: 100, height: 100)
    }
}

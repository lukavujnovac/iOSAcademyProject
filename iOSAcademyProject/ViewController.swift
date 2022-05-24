//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 24.05.2022..
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        
        return button
    }() 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signOutButton)
        
        signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
        signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        
        view.backgroundColor = .systemPurple
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
//            let authVC = AuthVC()
            
            self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print("An error occured signin out")
        }
    }
}

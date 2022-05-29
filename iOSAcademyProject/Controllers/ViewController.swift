//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 27.05.2022..
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
        view.backgroundColor = .red
 
        let teams = UserDefaults.standard.favoriteTeams()
        
        print("fav teams: \(teams)")
        
        view.addSubview(signOutButton)
        
        signOutButton.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    @objc func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.setIsLoggedIn(value: false)
        }catch {
            print("an error occured")
        }
    }
}

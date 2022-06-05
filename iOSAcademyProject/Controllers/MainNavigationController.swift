//
//  MainNavigationController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 24.05.2022..
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "home"), selectedImage: UIImage(systemName: "home.fill"))
        navigationController?.navigationBar.isHidden = false
        if isLoggedIn() {
            let vc = ExploreVC()
            viewControllers = [vc]
            
        }else {
            perform(#selector(showWelcomeVC), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }

    @objc func showWelcomeVC() {
        let welcomeVC = WelcomeVC()
        welcomeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true) { 
        }
    }
}


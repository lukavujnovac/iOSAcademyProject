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
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true) { 
        }
    }
}


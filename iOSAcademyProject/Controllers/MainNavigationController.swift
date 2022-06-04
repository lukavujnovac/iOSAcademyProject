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
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            navigationController?.navigationBar.isHidden = false
            viewControllers = [vc]
            reNew()
            
        }else {
            perform(#selector(showWelcomeVC), with: nil, afterDelay: 0.01)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    func reNew(){
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: ExploreVC())
    }
    
    
    @objc func showWelcomeVC() {
        let welcomeVC = WelcomeVC()
        welcomeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        welcomeVC.modalPresentationStyle = .fullScreen
        present(welcomeVC, animated: true) { 
        }
    }
}


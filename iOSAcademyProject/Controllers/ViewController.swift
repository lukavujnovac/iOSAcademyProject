//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 27.05.2022..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
 
        let teams = UserDefaults.standard.favoriteTeams()
        
        if !teams.isEmpty {
            print("fav teams empty")
        }else {
            print("fav teams: \(teams)")
        }
    }
}

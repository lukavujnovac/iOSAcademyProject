//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 01.06.2022..
//

import UIKit
import CoreData

class FavoritesVC: UIViewController {
    
    let table: UITableView = {
       let tv = UITableView()
        tv.register(TeamCell.self, forCellReuseIdentifier: TeamCell.identifier)
        
        return tv
    }()
    
    private var favoriteTeams = CoreDataManager.shared.favoriteTeams 
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var result:[TeamEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        view.backgroundColor = .systemBackground
        
        title = "Your Favorites"
        
        result = CoreDataManager.shared.teams()
        
        print(result.count)
        view.addSubview(table)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else {fatalError()}
        
        let team = result[indexPath.row]
        
        cell.teamImage.image = UIImage(named: team.name?.lowercased() ?? "")
        cell.teamLabel.text = team.fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

//
//  ViewController.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 24.05.2022..
//

import UIKit
import FirebaseAuth
import SnapKit

class FavouritesViewController: UIViewController {
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        
        return button
    }() 
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped) 
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        
        return table
    }()
    
    var models = MockData.models
    var favoriteTeams = MockData.favoriteTeams

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        setUpModels()
        configureNavigationItems()
        table.frame = CGRect(x: 10, y: 200, width: view.bounds.size.width, height: 200)
        table.separatorStyle = .none
        
        addViews()
        table.delegate = self
        table.dataSource = self
    }
    
    private func configureNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset Favorite Teams", style: .done, target: self, action: #selector(resetTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Continue", style: .plain, target: self, action: #selector(continueTapped))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    private func addViews() {
        view.addSubview(table)
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func continueTapped() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    @objc private func resetTapped() {
        UserDefaults.standard.resetFavoriteTeams()
    }
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
            case .list(let models): 
                return models.count
            case .collectionView(_, _):
                return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
            case .list(let models): 
                let model = models[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.text = model.title
                cell.backgroundColor = .clear
                
                return cell
            case .collectionView(let models, _):
                let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
                cell.configure(with: models)
                cell.delegate = self
                cell.layer.borderWidth = 2.0
                cell.layer.borderColor = UIColor.red.cgColor
                
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        print("did select normal list item")
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
            case .list(_): 
                return 16
            case .collectionView(_, let rows):
                return 170 * CGFloat(rows)
        }
    }
}

extension FavouritesViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("selected \(model.title)")
        
        if favoriteTeams.contains(model.title) {
            return
        }else {
            favoriteTeams.append(model.title)
            
            UserDefaults.standard.set(favoriteTeams, forKey: "favoriteTeams")
            UserDefaults.standard.synchronize()
        }
        print("favorites: \(favoriteTeams) ")
    }
}

private extension FavouritesViewController {
    func setUpModels() {
        models.append(.list(models: [ListCellModel(title: "What are your favorite NBA teams?")]))
        models.append(.list(models: [ListCellModel(title: "You can choose more than one. ")]))
        models.append(.list(models: [ListCellModel(title: "")]))
        models.append(.list(models: [ListCellModel(title: "Eastern Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Heat", imageName: "heat"), 
                                               CollectionTableCellModel(title: "Celtics", imageName: "celtics"),
                                               CollectionTableCellModel(title: "Bucks", imageName: "bucks"),
                                               CollectionTableCellModel(title: "76ers", imageName: "76ers"),
                                               CollectionTableCellModel(title: "Raptors", imageName: "raptors"),
                                               CollectionTableCellModel(title: "Bulls", imageName: "bulls"),
                                               CollectionTableCellModel(title: "Nets", imageName: "nets"),
                                               CollectionTableCellModel(title: "Hawks", imageName: "hawks"),
                                               CollectionTableCellModel(title: "Cavaliers", imageName: "cavaliers"),
                                               CollectionTableCellModel(title: "Hornets", imageName: "hornets"),
                                               CollectionTableCellModel(title: "Knicks", imageName: "knicks"),
                                               CollectionTableCellModel(title: "Wizards", imageName: "wizards"),
                                               CollectionTableCellModel(title: "Pacers", imageName: "pacers"),
                                               CollectionTableCellModel(title: "Pistons", imageName: "pistons"),
                                               CollectionTableCellModel(title: "Magic", imageName: "magic")],
                                      rows: 1))
        
        models.append(.list(models: [ListCellModel(title: "Western Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Suns", imageName: "suns"), 
                                               CollectionTableCellModel(title: "Grizzlies", imageName: "grizzlies"),
                                               CollectionTableCellModel(title: "Warriors", imageName: "warriors"),
                                               CollectionTableCellModel(title: "Mavericks", imageName: "mavericks"),
                                               CollectionTableCellModel(title: "Jazz", imageName: "jazz"),
                                               CollectionTableCellModel(title: "Nuggets", imageName: "nuggets"),
                                               CollectionTableCellModel(title: "Timberwolves", imageName: "timberwolves"),
                                               CollectionTableCellModel(title: "Pelicans", imageName: "pelicans"),
                                               CollectionTableCellModel(title: "Clippers", imageName: "clippers"),
                                               CollectionTableCellModel(title: "Spurs", imageName: "spurs"),
                                               CollectionTableCellModel(title: "Lakers", imageName: "lakers"),
                                               CollectionTableCellModel(title: "Kings", imageName: "kings"),
                                               CollectionTableCellModel(title: "Trail Blazers", imageName: "blazers"),
                                               CollectionTableCellModel(title: "Thunder", imageName: "thunder"),
                                               CollectionTableCellModel(title: "Rockets", imageName: "rockets")],
                                      rows: 1))
    }
}

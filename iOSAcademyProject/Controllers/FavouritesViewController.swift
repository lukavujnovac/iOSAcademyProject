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
    
    private var resetButton = UIBarButtonItem()
    private var confirmButton = UIBarButtonItem()
    private var continueButton = UIBarButtonItem()
    
    private var models = MockData.models
    private var favoriteTeams = MockData.favoriteTeams
    private var selectedTeams = [CellModel]()
    
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
        resetButton = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetTapped))
        resetButton.isEnabled = false
        
        confirmButton = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(confirmTapped))
        let continueButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(continueTapped))
        
        navigationItem.leftBarButtonItem = resetButton
        navigationItem.rightBarButtonItems = [continueButton, confirmButton]
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
    
    @objc private func confirmTapped() {
        models.append(contentsOf: selectedTeams)
        table.reloadData()
        resetButton.isEnabled = true
        confirmButton.isEnabled = false
    }                             
    
    @objc private func continueTapped() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
    @objc private func resetTapped() {
        UserDefaults.standard.resetFavoriteTeams()
        let range = selectedTeams.count
        models.removeLast(range)
        selectedTeams.removeAll()
        table.reloadData()
        favoriteTeams.removeAll()
        resetButton.isEnabled = false
        confirmButton.isEnabled = true
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
                return 120 * CGFloat(rows)
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
            selectedTeams.append(.collectionView(models: [model], rows: 1))
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
        models.append(.list(models: [ListCellModel(title: "After selecting click the arrow")]))
        models.append(.list(models: [ListCellModel(title: "Eastern Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "16", imageName: "heat"), 
                                               CollectionTableCellModel(title: "2", imageName: "celtics"),
                                               CollectionTableCellModel(title: "17", imageName: "bucks"),
                                               CollectionTableCellModel(title: "23", imageName: "76ers"),
                                               CollectionTableCellModel(title: "28", imageName: "raptors"),
                                               CollectionTableCellModel(title: "5", imageName: "bulls"),
                                               CollectionTableCellModel(title: "3", imageName: "nets"),
                                               CollectionTableCellModel(title: "1", imageName: "Hawks"),
                                               CollectionTableCellModel(title: "6", imageName: "cavaliers"),
                                               CollectionTableCellModel(title: "4", imageName: "hornets"),
                                               CollectionTableCellModel(title: "20", imageName: "knicks"),
                                               CollectionTableCellModel(title: "30", imageName: "wizards"),
                                               CollectionTableCellModel(title: "12", imageName: "pacers"),
                                               CollectionTableCellModel(title: "9", imageName: "pistons"),
                                               CollectionTableCellModel(title: "22", imageName: "magic")],
                                      rows: 1))
        
        models.append(.list(models: [ListCellModel(title: "Western Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "24", imageName: "suns"), 
                                               CollectionTableCellModel(title: "15", imageName: "grizzlies"),
                                               CollectionTableCellModel(title: "10", imageName: "warriors"),
                                               CollectionTableCellModel(title: "7", imageName: "mavericks"),
                                               CollectionTableCellModel(title: "29", imageName: "jazz"),
                                               CollectionTableCellModel(title: "8", imageName: "nuggets"),
                                               CollectionTableCellModel(title: "18", imageName: "timberwolves"),
                                               CollectionTableCellModel(title: "19", imageName: "pelicans"),
                                               CollectionTableCellModel(title: "13", imageName: "clippers"),
                                               CollectionTableCellModel(title: "27", imageName: "spurs"),
                                               CollectionTableCellModel(title: "14", imageName: "lakers"),
                                               CollectionTableCellModel(title: "26", imageName: "kings"),
                                               CollectionTableCellModel(title: "25", imageName: "blazers"),
                                               CollectionTableCellModel(title: "21", imageName: "thunder"),
                                               CollectionTableCellModel(title: "11", imageName: "rockets")],
                                      rows: 1))
        models.append(.list(models: [ListCellModel(title: "selected favorites")]))
        
    }
}

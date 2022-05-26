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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What are your favorite NBA teams?"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped) 
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        
        return table
    }()
    
    private var models = [CellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        setUpModels()
        table.frame = CGRect(x: 10, y: 200, width: view.bounds.size.width, height: 200)
        
        addViews()
        configureConstraints()
        table.delegate = self
        table.dataSource = self
//        view.addSubview(signOutButton)
//        signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
//        signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    private func setUpModels() {
//        models.append(.list(models: [ListCellModel(title: "Eastern Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Hawks", imageName: "Hawks"), 
                                               CollectionTableCellModel(title: "Nets", imageName: "nets"),
                                               CollectionTableCellModel(title: "Hornets", imageName: "hornets"),
                                               CollectionTableCellModel(title: "Bulls", imageName: "bulls")],
                                      rows: 1))
        
        models.append(.list(models: [ListCellModel(title: "Western Conference")]))
        
        models.append(.collectionView(models: [CollectionTableCellModel(title: "Hawks", imageName: "Hawks"), 
                                               CollectionTableCellModel(title: "Nets", imageName: "nets"),
                                               CollectionTableCellModel(title: "Hornets", imageName: "hornets"),
                                               CollectionTableCellModel(title: "Bulls", imageName: "bulls")],
                                      rows: 1))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    private func addViews() {
        view.addSubview(table)
        view.addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }
        
        table.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(200)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.setIsLoggedIn(value: false)
            
            let welcomeVC = WelcomeVC()
            welcomeVC.modalPresentationStyle = .fullScreen
            
            present(welcomeVC, animated: true)
        }catch{
            print("An error occured signin out")
        }
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
                
                return cell
            case .collectionView(let models, _):
                let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
                cell.configure(with: models)
                cell.delegate = self
                
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("did select normal list item")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
            case .list(_): 
                return 50
            case .collectionView(_, let rows):
                return 122 * CGFloat(rows)
        }
    }
}

extension FavouritesViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("selected \(model.title)")
    }
}

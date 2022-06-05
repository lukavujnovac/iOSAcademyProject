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
    
    private let tableEmptyView = EmptyView(frame: CGRect.zero)
    
    private var favoriteTeams = CoreDataManager.shared.favoriteTeams 
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var result:[TeamEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        view.backgroundColor = .systemBackground
        
        title = "Your Favorites"
        tableEmptyView.isHidden = false
        
        result = CoreDataManager.shared.teams()
        
        print(result.count)
        view.addSubview(table)
        view.addSubview(tableEmptyView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        result = CoreDataManager.shared.teams()
        table.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        tableEmptyView.frame = view.bounds
    }
}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if result.isEmpty {
            tableEmptyView.isHidden = false
        }else {
            tableEmptyView.isHidden = true
        }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
                let team = result[indexPath.row]
                CoreDataManager.shared.delete(object: team)
                result.remove(at: indexPath.row)
                table.deleteRows(at: [indexPath], with: .fade)
                table.reloadData()
                if !result.isEmpty {
                    team.isFavorite = false
                }
            default:
                return
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let team = result[indexPath.row]
        let teams = result.compactMap{ TeamViewModel(fullName: $0.fullName ?? "", id: Int($0.id), abbreviation: $0.abbreviation ?? "", city: $0.city ?? "", division: $0.division ?? "", imageString: $0.name ?? "", conference: $0.conference ?? "", name: $0.name ?? "")}
        
        let viewModel = teams[indexPath.row]
        
        let vc = TeamDetailVC(viewModel: viewModel)
        print(viewModel.id)
        
        print(CoreDataManager.shared.favoriteTeams)
        
        navigationController?.pushViewController(vc, animated: true)
    }

    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "remove") { action, view ,boolValue  in
//            CoreDataManager.shared.delete(object: self.result[indexPath.row])
//            self.table.deleteRows(at: [indexPath], with: .automatic)
//        }
//        
//        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
//        return swipeActions
//    }
}

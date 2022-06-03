//
//  PlayerListVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 02.06.2022..
//

import UIKit

class PlayerListVC: UIViewController {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.identifier)
        
        return table
    }()
    
    private var viewModels = [PlayerCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Players"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        ApiCaller.shared.getPlayers { [weak self] result in
            switch result {
                case.success(let players):
                    self?.viewModels = players.compactMap({
                        PlayerCellViewModel(firstName: $0.firstName, lastName: $0.lastName, teamName: $0.team.name, imageUrl: nil, id: $0.id)
                    })
                    
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                    }
                case.failure(let error):
                    print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
    }
}

extension PlayerListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: PlayerCell.identifier, for: indexPath) as? PlayerCell else {fatalError()}
        
        cell.configure(with: viewModels[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
}

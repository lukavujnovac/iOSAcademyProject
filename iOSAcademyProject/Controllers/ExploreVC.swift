//
//  ExploreVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 31.05.2022..
//

import UIKit

class ExploreVC: UIViewController{
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(TeamCell.self, forCellReuseIdentifier: TeamCell.identifier)
        
        return table
    }()
    
    private var viewModels = [TeamCellViewModel]()
    private var teams = [Team]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        ApiCaller.shared.getTeams { [weak self] result in
            switch result {
                case .success(let teams):
                    self?.teams = teams
                    self?.viewModels = teams.compactMap({TeamCellViewModel(fullName: $0.full_name, imageName: $0.name.lowercased())})
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        table.frame = view.bounds
    }
}

extension ExploreVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

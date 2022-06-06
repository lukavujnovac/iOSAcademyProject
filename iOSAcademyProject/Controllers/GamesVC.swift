//
//  GamesVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//

import UIKit

class GamesVC: UIViewController {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        
        return table
    }()
    
    private var viewModels = [GameViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Games"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        ApiCaller.shared.getGames {[weak self] result in
            switch result {
                case .success(let games):
                    self?.viewModels = games.compactMap({GameViewModel(id: $0.id, date: $0.date, homeTeamScore: $0.homeTeamScore, visitorTeamScore: $0.visitorTeamScore, season: $0.season, period: $0.period, status: $0.status, time: $0.time, postseason: $0.postseason, homeTeam: $0.homeTeam, visitorTeam: $0.visitorTeam)})
                    
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                    }
                    
                case .failure(let error):
                    print("error: \(error)")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}

extension GamesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: GameCell.identifier, for: indexPath) as? GameCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

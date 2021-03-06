//
//  GamesVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 06.06.2022..
//

import UIKit
import SwiftUI

class GamesVC: UIViewController {
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(GameCell.self, forCellReuseIdentifier: GameCell.identifier)
        
        return table
    }()
    
    private var viewModels = [GameViewModel]()
    
    let team: Int?
    private var pageTeam: Int = 1
    private var page = 0
    private var totalPages = 57
    private let totalPagesTeam = 4
    private let apiCaller = ApiCaller()
    
    init(team: Int?) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Games"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        showSpinner()
        
        ApiCaller.shared.getGames {[weak self] result in
            switch result {
                case .success(let games):
                    self?.viewModels = games.compactMap({GameViewModel(id: $0.id, date: $0.date, homeTeamScore: $0.homeTeamScore, visitorTeamScore: $0.visitorTeamScore, season: $0.season, period: $0.period, status: $0.status, time: $0.time, postseason: $0.postseason, homeTeam: $0.homeTeam, visitorTeam: $0.visitorTeam)})
                    
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                        self?.removeSpinner()
                    }
                    
                case .failure(let error):
                    print("error: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if team == nil {
            ApiCaller.shared.getGames {[weak self] result in
                switch result {
                    case .success(let games):
                        self?.viewModels = games.compactMap({GameViewModel(id: $0.id, date: $0.date, homeTeamScore: $0.homeTeamScore, visitorTeamScore: $0.visitorTeamScore, season: $0.season, period: $0.period, status: $0.status, time: $0.time, postseason: $0.postseason, homeTeam: $0.homeTeam, visitorTeam: $0.visitorTeam)})
                        
                        DispatchQueue.main.async {
                            self?.table.reloadData()
                            self?.removeSpinner()
                        }
                        
                    case .failure(let error):
                        print("error: \(error)")
                }
            }
        }else {
            ApiCaller.shared.getGamesForTeam(page: pageTeam, teamId: team ?? 0) { [weak self] result in
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
    }
    
    private func showSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }

    
    private func getMoreTeamGames(page: Int) {
        ApiCaller.shared.getGamesForTeam(page: page, teamId: team ?? 0) { [weak self] result in
            switch result {
                case .success(let games):
                    let moreGames = games.compactMap({GameViewModel(id: $0.id, date: $0.date, homeTeamScore: $0.homeTeamScore, visitorTeamScore: $0.visitorTeamScore, season: $0.season, period: $0.period, status: $0.status, time: $0.time, postseason: $0.postseason, homeTeam: $0.homeTeam, visitorTeam: $0.visitorTeam)})
                    
                    self?.viewModels.append(contentsOf: moreGames)
                    
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
        
        let games = viewModels.compactMap{ GameViewModel(id: $0.id, date: $0.date, homeTeamScore: $0.homeTeamScore, visitorTeamScore: $0.visitorTeamScore, season: $0.season, period: $0.period, status: $0.status, time: $0.time, postseason: $0.postseason, homeTeam: $0.homeTeam, visitorTeam: $0.visitorTeam)}
        
        let viewModel = games[indexPath.row]
        
        let vc = GameDetailVC(viewModel: viewModel)
        print(viewModel.id)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModels.count - 3
        if indexPath.row == lastItem { 
            table.tableFooterView = showSpinnerFooter()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { 
                
                if self.pageTeam < self.totalPagesTeam {
                    self.pageTeam += 1   
                    self.table.tableFooterView = .none
                    self.getMoreTeamGames(page: self.pageTeam)
                } 
                self.table.reloadData()
                self.table.tableFooterView = nil
            }
        }
    }
}

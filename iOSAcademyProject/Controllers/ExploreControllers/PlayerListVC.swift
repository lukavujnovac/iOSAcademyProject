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
    
    private let apiCaller = ApiCaller()
    private var playerImageUrls = [String]()
    private var viewModels = [PlayerViewModel]()
    private var playerImages = [PlayerImage]()
    private var currentPage = 0
    private let totalPages = 151
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Players"
        view.backgroundColor = .systemBackground
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        showSpinner()
//        navigationItem.searchController = searchController
        
        ApiCaller.shared.getPlayers(pagination: false, page: currentPage) { [weak self] result in
            switch result {
                case.success(let players):
                    self?.fetchPlayerPhotos(for: players[players.distance(from: players.startIndex, to: players.startIndex)].id)
                    self?.viewModels = players.compactMap({
                        PlayerViewModel(id: $0.id, firstName: $0.firstName, lastName: $0.lastName, heightFeet: $0.heightFeet ?? 0, heightInches: $0.heightInches ?? 0, position: $0.position, team: $0.team, weightPounds: $0.weightPounds ?? 0)
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
        removeSpinner()
    }
    
    func fetchPlayerPhotos(for id: Int){
        let urlString = "\(ApiCaller.Constants.playerImageURL)\(id)"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(PlayerImageApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.playerImages = result.data
                    let playerImageUrl = result.data[0].imageUrl 
                    self?.playerImageUrls.append(playerImageUrl)
                }
            }catch {
                print(error)
            }
        }
        task.resume()
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
        //        if playerImageUrls.isEmpty {
        //            cell.configure(with: viewModels[indexPath.row], for: "")
        //            fetchPlayerPhotos(for: viewModels[indexPath.row].id)
        //        }else {
        //            cell.configure(with: viewModels[indexPath.row], for: playerImageUrls[0] ?? "")
        //        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        let vc = PlayerDetailVC(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
}

extension PlayerListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (table.contentSize.height - 100 - scrollView.frame.size.height) {
            guard currentPage <= totalPages else {return}
            currentPage += 1
            guard !apiCaller.isPaginating else {return}
            
            self.table.tableFooterView = showSpinnerFooter()
            
            ApiCaller.shared.getPlayers(pagination: true, page: currentPage) { [weak self] result  in
                DispatchQueue.main.async {
                    self?.table.tableFooterView = nil
                }
                switch result {
                    case.success(let morePlayers):
                        self?.viewModels.append(contentsOf: morePlayers.compactMap({
                            PlayerViewModel(id: $0.id, firstName: $0.firstName, lastName: $0.lastName, heightFeet: $0.heightFeet ?? 0, heightInches: $0.heightInches ?? 0, position: $0.position, team: $0.team, weightPounds: $0.weightPounds ?? 0)}))
                        
                        DispatchQueue.main.async {
                            self?.table.reloadData()
                        }
                    case.failure(let error):
                        print(error)
                }
            }
        }
    }
}

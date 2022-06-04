//
//  ExploreVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 31.05.2022..
//

import UIKit
import FirebaseAuth

class ExploreVC: UIViewController{
    
    private let table: UITableView = {
        let table = UITableView()
        table.register(TeamCell.self, forCellReuseIdentifier: TeamCell.identifier)
        
        return table
    }()
    
    private let tableEmptyView = EmptyView(frame: CGRect.zero)
    
    private lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        s.searchResultsUpdater = self
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Search"
        s.searchBar.sizeToFit()
        s.searchBar.searchBarStyle = .prominent
        s.searchBar.scopeButtonTitles = ["All", "West", "East"]
        s.searchBar.delegate = self
        s.searchBar.backgroundColor = .systemBackground
        
        return s
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        
        return button
    }() 
    private var viewModels = [TeamCellViewModel]()
    private var teams = [Team]()
    private var filteredTeams = [Team]()
    
    private var showingTeams: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.changeShowingTeams(value: showingTeams)
        view.backgroundColor = .systemBackground
        navigationItem.searchController = searchController
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(table)
        setupEmptyView()
        table.delegate = self
        table.dataSource = self
        showSpinner()
        navigationController?.navigationBar.isHidden = false
        tableEmptyView.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show player list", style: .done, target: self, action: #selector(changeListTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "log out", style: .plain, target: self, action: #selector(logOutTapped))
        
        ApiCaller.shared.getTeams { [weak self] result in
            switch result {
                case .success(let teams):
                    self?.teams = teams
                    self?.viewModels = teams.compactMap({TeamCellViewModel(fullName: $0.fullName, imageName: $0.name.lowercased(), id: $0.id, conference: $0.conference)})
                    DispatchQueue.main.async {
                        self?.table.reloadData()
                        self?.removeSpinner()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        tableEmptyView.frame = view.bounds
    }
    
    func checkIsEmpty() {
        if filteredTeams.isEmpty {
            print("no data")
            tableEmptyView.isHidden = false
        }else {
            print("data")
            tableEmptyView.isHidden = true
        }
    }
    
//    func layoutEmptyView() {
//        tableEmptyView.frame = view.bounds
//    }
    
    func setupEmptyView() {
        view.addSubview(tableEmptyView)
    }
    
    @objc private func changeListTapped() {
        let vc = PlayerListVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExploreVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {return filteredTeams.count}
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: TeamCell.identifier, for: indexPath) as? TeamCell else {fatalError()}
        
        let currentTeam: Team 
        if isFiltering() {
            currentTeam = filteredTeams[indexPath.row]
        }else {
            currentTeam = teams[indexPath.row]
        }
        
        cell.teamLabel.text = currentTeam.fullName
        cell.teamImage.image = UIImage(named: currentTeam.name.lowercased())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        print(viewModel.id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ExploreVC: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchText: searchBar.text!, scope: scope)
        
        checkIsEmpty()
    }
    
    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredTeams = teams.filter({ team in
            let doesCategoryMatch = (scope == "All") || (team.conference == scope) 
            
            if isSearchBarEmpty() {
                return doesCategoryMatch
            }else {
                return doesCategoryMatch && team.fullName.lowercased().contains(searchText.lowercased())
            }
        })
        
        table.reloadData()
    }
    
    private func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || searchBarScopeIsFiltering)
    }
} 

private extension ExploreVC {
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

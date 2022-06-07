//
//  PlayerDetailVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import UIKit
import SDWebImage
import SnapKit

class PlayerDetailVC: UIViewController {
    private var playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemBlue
        
        return iv
    }()
    
    private var teamImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.backgroundColor = .systemBlue
        
        return iv
    }()
    
    private var teamNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let positionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    let viewModel: PlayerViewModel
    private var playerImageUrls = [String]()
    private var playerImages = [PlayerImage]()
    private var playerImageUrlString: String? = ""
    private var hasImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let fullNameString = "\(viewModel.firstName) \(viewModel.lastName)"
        title = fullNameString
        configure(with: viewModel)
        addSubviews()
        fetchPlayerImage()
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getImageUrl(for: viewModel.id)
    }
    
    private func addSubviews() {
        view.addSubview(playerImageView)
        view.addSubview(teamImageView)
        view.addSubview(teamNameLabel)
        view.addSubview(positionLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
    }
    
    private func configure(with viewModel: PlayerViewModel) {
        self.playerImageView.image = UIImage(named: viewModel.position)
        self.teamImageView.image = UIImage(named: viewModel.team.name?.lowercased() ?? "")
        self.teamNameLabel.text = viewModel.team.fullName
        self.positionLabel.text = viewModel.position
        self.heightLabel.text = "Height: \(viewModel.heightFeet)' \(viewModel.heightInches)''"
        self.weightLabel.text = "Weight: \(viewModel.weightPounds) lbs"
    }
    
    private func configureConstraints() {
        playerImageView.snp.makeConstraints { 
            $0.width.equalTo(343)
            $0.height.equalTo(328)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(136)
        }
        teamImageView.snp.makeConstraints { 
            $0.leading.equalTo(playerImageView.snp.leading)
            $0.top.equalTo(playerImageView.snp.bottom).offset(36)
            $0.width.height.equalTo(80)
        }
        teamNameLabel.snp.makeConstraints { 
            $0.leading.equalTo(teamImageView.snp.trailing).offset(18)
            $0.top.equalTo(teamImageView.snp.top)
        }
        
        positionLabel.snp.makeConstraints { 
            $0.leading.equalTo(teamNameLabel.snp.leading)
            $0.bottom.equalTo(teamImageView.snp.bottom)
        }
        
        heightLabel.snp.makeConstraints { 
            $0.top.equalTo(teamImageView.snp.bottom).offset(36)
            $0.leading.equalToSuperview().offset(40)
        }
        
        weightLabel.snp.makeConstraints { 
            $0.top.equalTo(teamImageView.snp.bottom).offset(36)
            $0.trailing.equalToSuperview().offset(-40)
        }
    }
    
    private func getImageUrl(for id: Int){
        let urlString = "\(ApiCaller.Constants.playerImageURL)\(id)"
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            guard let data = data, error == nil else {return}
            do {
                let result = try JSONDecoder().decode(PlayerImageApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.hasImage = true
                    self?.playerImages = result.data 
                    self?.playerImageUrlString = result.data[0].imageUrl ?? ""
                    let urlString = result.data[0].imageUrl ?? ""
                    self?.playerImageView.backgroundColor = .systemBackground
                    self?.playerImageView.sd_setImage(with: URL(string: urlString), completed: nil)
                }
            }catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func fetchPlayerImage() {
        guard let url = URL(string: playerImageUrlString!) else {return}
        let getDataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.playerImageView.image = nil
                self?.playerImageView.backgroundColor = .systemBackground
                self?.playerImageView.image = image
                self?.hasImage = true
            }
        }
        getDataTask.resume()
    }
}

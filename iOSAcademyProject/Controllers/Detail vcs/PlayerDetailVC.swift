//
//  PlayerDetailVC.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 04.06.2022..
//

import UIKit

class PlayerDetailVC: UIViewController {
    
    let viewModel: PlayerViewModel
    private var playerImageUrls = [String]()
    private var playerImages = [PlayerImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.lastName
    }
    
    init(viewModel: PlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchPlayerPhotos(for: viewModel.id)
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
                    print("image count: \(self?.playerImages.count)")
                }
            }catch {
                print(error)
            }
        }
        task.resume()
    }
}

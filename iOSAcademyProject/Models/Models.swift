//
//  Models.swift
//  iOSAcademyProject
//
//  Created by Luka Vujnovac on 26.05.2022..
//

import Foundation

enum CellModel {
    case collectionView(models: [CollectionTableCellModel], rows: Int)
    case list(models: [ListCellModel])
}

struct ListCellModel {
    let title: String
}

struct CollectionTableCellModel: Equatable {
    let title: String
    let imageName: String
}

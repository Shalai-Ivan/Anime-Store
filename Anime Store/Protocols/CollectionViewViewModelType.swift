//
//  CollectionViewViewModelType.swift
//  Anime Store
//
//  Created by MacMini on 9.10.22.
//

import UIKit

protocol CollectionViewViewModelType {
    func getImagesCount() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath, forTag tag: Int) -> CollectionViewCellViewModelType
}

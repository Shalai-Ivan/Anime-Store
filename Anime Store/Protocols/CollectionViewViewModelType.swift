//
//  CollectionViewViewModelType.swift
//  Anime Store
//
//  Created by MacMini on 9.10.22.
//

import UIKit

protocol CollectionViewViewModelType {
    func getImagesCount(forTag tag: Int) -> Int
    func getAnimeName(forIndexPath indexPath: IndexPath, forTag tag: Int) -> String
}

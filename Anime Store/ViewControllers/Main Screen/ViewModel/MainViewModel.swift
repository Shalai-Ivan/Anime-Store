//
//  MainViewModel.swift
//  Anime Store
//
//  Created by MacMini on 7.10.22.
//

import UIKit

class MainViewModel {
    private let networkManager = NetworkManager()
    var images: [UIImage] {
        Array(0...5).compactMap { UIImage(named: "item\($0)") }
    }
    var imageName: String = "Name"
}

extension MainViewModel: CollectionViewViewModelType {
    func getImagesCount() -> Int {
        return images.count
    }
    func cellViewModel(forIndexPath indexPath: IndexPath, forTag tag: Int) -> CollectionViewCellViewModelType {
        switch tag {
        case 0:
            let image = images[indexPath.row]
            return MainViewModelCell(image: image, text: imageName)
        default:
            let image = images[indexPath.row]
            return MainViewModelCell(image: image, text: imageName)
        }
    }
}

//
//  MainViewModel.swift
//  Anime Store
//
//  Created by MacMini on 7.10.22.
//

import UIKit

class MainViewModel {
    var images: [UIImage] {
        Array(0...5).compactMap { UIImage(named: "item\($0)") }
    }
    var imageName: String = "Name"
}

extension MainViewModel: CollectionViewViewModelType {
    func getImagesCount() -> Int {
        return images.count
    }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CollectionViewCellViewModelType {
        let image = images[indexPath.row]
        return MainViewModelCell(image: image, text: imageName)
    }
}

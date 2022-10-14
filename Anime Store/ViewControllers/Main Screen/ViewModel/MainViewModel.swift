//
//  MainViewModel.swift
//  Anime Store
//
//  Created by MacMini on 7.10.22.
//

import UIKit

class MainViewModel {
    private let networkManager = NetworkManager()
    var defaultImages: [UIImage] {
        Array(0...5).compactMap { UIImage(named: "item\($0)") }
    }
    var defaultTitle: String = "Name"
    var topApiModels: [AnimeModel] {
        self.networkManager.fetchRequest(typeRequest: .apiTop)
    }
    var topAdminModels: [AnimeModel] {
        let arrayNames = ["Bleach", "Attack%20on%20Titan", "Demon%20Slayer", "Death%20Note", "Naruto"]
        return arrayNames.flatMap { networkManager.fetchRequest(typeRequest: .name(name: $0))}
    }
    var topUsersModels: [AnimeModel] {
        let arrayNames = ["Fullmetal%20Alchemist", "Cowboy%20Bebop", "One%20Piece", "Monster", "Hajime%20no%20Ippo", "Mob%20Psycho%20100", "Hunter%20x%20Hunter", "Neon%20Genesis%20Evangelion", "Yu%20Yu%20Hakusho", "FLCL"]
        return arrayNames.flatMap { networkManager.fetchRequest(typeRequest: .name(name: $0))}
    }
}

extension MainViewModel: CollectionViewViewModelType {
    func getImagesCount(forTag tag: Int) -> Int {
        switch tag {
        case 0:
            return defaultImages.count
        case 1:
            return topApiModels.count
        case 2:
            return topAdminModels.count
        case 3:
            return topUsersModels.count
        default:
            return defaultImages.count
        }
    }
    func cellViewModel(forIndexPath indexPath: IndexPath, forTag tag: Int) -> CollectionViewCellViewModelType {
        switch tag {
        case 0:
            let image = defaultImages[indexPath.row]
            return MainViewModelCell(image: image, text: defaultTitle)
        case 1:
            let model = topApiModels[indexPath.row]
            return MainViewModelCell(image: model.image, text: model.title)
        case 2:
            let model = topAdminModels[indexPath.row]
            return MainViewModelCell(image: model.image, text: model.title)
        case 3:
            let model = topUsersModels[indexPath.row]
            return MainViewModelCell(image: model.image, text: model.title)
        default:
            let image = UIImage(named: "noImage")!
            return MainViewModelCell(image: image, text: defaultTitle)
        }
    }
}

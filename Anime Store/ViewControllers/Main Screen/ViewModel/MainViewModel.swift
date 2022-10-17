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
    let mainViewAnime = ["Kimetsu%20no%20Yaiba", "JoJo’s%20Bizarre%20Adventure", "My%20Dress%20Up%20Darling", "The%20Orbital%20Children", "Ranking%20of%20Kings", "Kaguya-sama:%20Love%20Is%20War%20Ultra%20Romantic", "Rust-Eater%20Bisco", "World’s%20End%20Harem", "Attack%20on%20Titan%20(Final%20Season%20Part%202)", "Spy%20×%20Family"]
    let topAdminArray = ["Bleach", "Attack%20on%20Titan", "Demon%20Slayer", "Death%20Note", "Naruto"]
    let topUsersArray = ["Fullmetal%20Alchemist", "Cowboy%20Bebop", "One%20Piece", "Monster", "Hajime%20no%20Ippo", "Mob%20Psycho%20100", "Hunter%20x%20Hunter", "Neon%20Genesis%20Evangelion", "Yuu%20Yuu%20Hakusho", "FLCL"]
}

extension MainViewModel: CollectionViewViewModelType {
    func getImagesCount(forTag tag: Int) -> Int {
        switch tag {
        case 0:
            return mainViewAnime.count
        case 1:
            return 10
        case 2:
            return topAdminArray.count
        case 3:
            return topUsersArray.count
        default:
            return defaultImages.count
        }
    }
    func getAnimeName(forIndexPath indexPath: IndexPath, forTag tag: Int) -> String {
        switch tag {
        case 0:
            return mainViewAnime[indexPath.row]
        case 2:
            return topAdminArray[indexPath.row]
        case 3:
            return topUsersArray[indexPath.row]
        default:
            return defaultTitle
        }
    }
}

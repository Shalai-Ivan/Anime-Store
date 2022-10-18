//
//  AnimeModel.swift
//  Anime Store
//
//  Created by MacMini on 11.10.22.
//

import UIKit

class AnimeModel {
    let image: UIImage
    let title: String
    init(image: UIImage, title: String) {
        self.image = image
        self.title = title
    }
    static func getArray(animeData: AnimeData) -> [AnimeModel] {
        var animeModels: [AnimeModel] = []
        for item in animeData.data {
            let image = downloadImage(stringURL: item.images.jpg.image)
            animeModels.append(AnimeModel(image: image, title: item.title))
        }
        return animeModels
    }
    static func downloadImage(stringURL: String) -> UIImage {
        let defaultImage = UIImage(named: "noImage")!
        guard let url = URL(string: stringURL) else { return defaultImage }
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data) ?? defaultImage
        } catch let error {
            print("Error image downloading - \(error.localizedDescription)")
        }
        return defaultImage
    }
}

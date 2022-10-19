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
            downloadImage(stringURL: item.images.jpg.image) { image in
                animeModels.append(AnimeModel(image: image, title: item.title))
            }
        }
        return animeModels
    }
    static func downloadImage(stringURL: String, completionHandler: @escaping (UIImage) -> Void) {
        let defaultImage = UIImage(named: "noImage")!
        guard let url = URL(string: stringURL) else { return }
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data) ?? defaultImage
            completionHandler(image)
        } catch let error {
            print("Error image downloading - \(error.localizedDescription)")
        }
    }
}

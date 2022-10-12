//
//  AnimeModel.swift
//  Anime Store
//
//  Created by MacMini on 11.10.22.
//

import Foundation

struct AnimeModel {
    let imageURL: String
    let title: String
    init?(animeData: AnimeData) {
        self.imageURL = animeData.data.first?.images.jpg.imageUrl ?? "No imageURL"
        self.title = animeData.data.first?.titles.first?.title ?? "Nixy9"
    }
}

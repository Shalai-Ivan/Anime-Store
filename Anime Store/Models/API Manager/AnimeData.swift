//
//  AnimeData.swift
//  Anime Store
//
//  Created by MacMini on 11.10.22.
//

import Foundation

struct AnimeData: Codable {
    let data: [DataType]
}

struct DataType: Codable {
    let images: Images
    let titles: [Titles]
}

struct Titles: Codable {
    let title: String
}
struct Images: Codable {
    let jpg: Jpg
}

struct Jpg: Codable {
    let imageUrl: String
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
}

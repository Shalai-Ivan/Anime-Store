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
    let title: String
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case title = "title_english"
    }
}

struct Images: Codable {
    let jpg: Jpg
}

struct Jpg: Codable {
    let image: String
    enum CodingKeys: String, CodingKey {
        case image = "image_url"
    }
}

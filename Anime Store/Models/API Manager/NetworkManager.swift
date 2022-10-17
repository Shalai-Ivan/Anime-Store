//
//  NetworkManager.swift
//  Anime Store
//
//  Created by MacMini on 11.10.22.
//

import Alamofire
import SwiftyJSON
import UIKit

enum TypeRequest {
    case name(name: String)
    case apiTop
}

class NetworkManager {
    var completionHandler: (([AnimeModel]) -> ())?
    func fetchRequest(typeRequest: TypeRequest, completionHandler: @escaping ([AnimeModel]) -> ()) {
        var animeModels: [AnimeModel] = []
        switch typeRequest {
        case .name(let name):
            let urlString = "https://api.jikan.moe/v4/anime?q=\(name)"
            AF.request(urlString).response { response in
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    let title = json["data"][0]["title_english"].string ?? "Anime"
                    let imageURL = json["data"][0]["images"]["jpg"]["image_url"].string ?? ""
                    let image = AnimeModel.downloadImage(stringURL: imageURL)
                    animeModels.append(AnimeModel(image: image, title: title))
                    completionHandler(animeModels)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        case .apiTop:
            let urlString = "https://api.jikan.moe/v4/top/anime?limit=10"
            AF.request(urlString).responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let animeData = try JSONDecoder().decode(AnimeData.self, from: data)
                    animeModels = AnimeModel.getArray(animeData: animeData)
                    completionHandler(animeModels)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
        }
    }
}

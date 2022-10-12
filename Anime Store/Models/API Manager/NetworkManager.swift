//
//  NetworkManager.swift
//  Anime Store
//
//  Created by MacMini on 11.10.22.
//

import Alamofire
import UIKit

enum TypeRequest {
    case name(name: String)
    case apiTop
}

class NetworkManager {
    func fetchRequest(typeRequest: TypeRequest) -> AnimeModel? {
        var animeModel: AnimeModel?
        var urlString = ""
        switch typeRequest {
        case .name(let name):
            urlString = "https://api.jikan.moe/v4/anime?q=\(name)"
        case .apiTop:
            urlString = "https://api.jikan.moe/top/anime/"
        }
        AF.request(urlString).responseJSON(completionHandler: { responce in
            guard let data = responce.data else { return print("No data")}
            do {
                let animeData = try JSONDecoder().decode(AnimeData.self, from: data)
                animeModel = AnimeModel(animeData: animeData)
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
        })
        return animeModel
    }
}

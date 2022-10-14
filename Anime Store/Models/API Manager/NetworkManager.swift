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
    func fetchRequest(typeRequest: TypeRequest) -> [AnimeModel] {
        var animeModels: [AnimeModel] = []
        switch typeRequest {
        case .name(let name):
            let urlString = "https://api.jikan.moe/v4/anime?q=\(name)"
            AF.request(urlString).response { response in
                guard let data = response.data else { return print("NO DATA FOR - \(name)") }
                do {
                    let json = try JSON(data: data)
                    let title = json["data"][0]["title_english"].string ?? "Anime"
                    let imageURL = json["data"][0]["images"]["jpg"]["image_url"].string ?? ""
                    let image = AnimeModel.downloadImage(stringURL: imageURL)
                    animeModels.append(AnimeModel(image: image, title: title))
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
            AF.request(urlString).responseJSON(completionHandler: { response in
                guard let data = response.data else { return print("NO DATA FOR APITOP")}
                do {
                    let animeData = try JSONDecoder().decode(AnimeData.self, from: data)
                    animeModels = AnimeModel.getArray(animeData: animeData)
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
        }
        return animeModels
    }
   
}

//            AF.request(urlString).responseJSON(completionHandler: { response in
//                switch response.result {
//                case .success(let value):
//                    guard let dictionary1 = value as? Dictionary<String, Any> else { return print("NO DICTIOANRY1")}
//                    guard let array = dictionary1["data"] as? Array<[String:Any]> else { return print("NO ARRAY")}
//                    guard let dictionary2 = array.first?["images"] as? Dictionary<String, Any> else { return print("NO DICTI3")}
//                    guard let dictionary3 = dictionary2["jpg"] as? Dictionary<String, String> else { return print("NO DICTI4")}
//                    let title = (array.first?["title"] ?? "") as? String
//                    let data = try! Data(contentsOf: URL(string: dictionary3["image_url"]!)!)
//                    print("IMAGE_URL - \(dictionary3["image_url"])")
//                    let image = UIImage(data: data)
//                    animeModels.append(AnimeModel(image: image ?? (UIImage(named: "noImage")!), title: title ?? "Name"))
//                case .failure(let error):
//                    print("ERROR \(error.localizedDescription)")
//                }
//            })

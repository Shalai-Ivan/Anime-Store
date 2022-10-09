//
//  CollectionViewCellViewModelType.swift
//  Anime Store
//
//  Created by MacMini on 9.10.22.
//

import UIKit

protocol CollectionViewCellViewModelType: AnyObject {
    var image: UIImage { get set }
    var text: String { get set }
}

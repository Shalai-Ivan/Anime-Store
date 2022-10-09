//
//  MainViewModelCell.swift
//  Anime Store
//
//  Created by MacMini on 9.10.22.
//

import UIKit

class MainViewModelCell: CollectionViewCellViewModelType {
    var image: UIImage
    var text: String
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
}

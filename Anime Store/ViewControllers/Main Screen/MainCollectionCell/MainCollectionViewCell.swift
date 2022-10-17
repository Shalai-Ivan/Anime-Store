//
//  MainCollectionViewCell.swift
//  Anime Store
//
//  Created by MacMini on 8.10.22.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet  weak var imageView: UIImageView!
    @IBOutlet  weak var nameTextLabel: UILabel!
    var animeModel: AnimeModel? {
        didSet {
            guard let animemModel = animeModel else { return }
            imageView.image = animemModel.image
            nameTextLabel.text = animemModel.title
        }
    }
    @IBAction func didTapToLeftButton(_ sender: Any) {
    }
    @IBAction func didTapToRightButton(_ sender: Any) {
    }
}

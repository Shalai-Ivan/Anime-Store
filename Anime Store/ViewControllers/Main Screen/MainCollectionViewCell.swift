//
//  MainCollectionViewCell.swift
//  Anime Store
//
//  Created by MacMini on 8.10.22.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextLabel: UILabel!
    weak var viewModel: CollectionViewCellViewModelType? {
        didSet {
            guard let viewModel = viewModel else { return }
            imageView.image = viewModel.image
            nameTextLabel.text = viewModel.text
        }
    }
    @IBAction func didTapToLeftButton(_ sender: Any) {
    }
    @IBAction func didTapToRightButton(_ sender: Any) {
    }
}

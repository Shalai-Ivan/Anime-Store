//
//  MainCollectionViewCell.swift
//  Anime Store
//
//  Created by MacMini on 8.10.22.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameTextLabel: UILabel!
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

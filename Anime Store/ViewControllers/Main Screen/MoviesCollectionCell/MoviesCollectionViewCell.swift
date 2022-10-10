//
//  MoviesCollectionViewCell.swift
//  Anime Store
//
//  Created by MacMini on 10.10.22.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var moviesImageView: UIImageView!
    weak var viewModel: CollectionViewCellViewModelType? {
        didSet {
            guard let viewModel = viewModel else { return print("No guard cell")}
            moviesImageView.image = viewModel.image
        }
    }
}

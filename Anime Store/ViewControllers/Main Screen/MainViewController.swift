//
//  MainViewController.swift
//  Anime Store
//
//  Created by MacMini on 6.10.22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: CollectionViewViewModelType?
    private var imageNumber: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
    }
    @IBAction private func unwindSegueToMain(_ sender: UIStoryboardSegue) {
    }
    @IBAction func didTapToLeftButton(_ sender: Any) {
        guard let counts = viewModel?.getImagesCount() else { return }
        if imageNumber < counts - 1 {
            imageNumber += 1
            collectionView.scrollToItem(at: IndexPath(row: imageNumber, section: 0), at: .left, animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            imageNumber = 0
        }
    }
    @IBAction func didTapToRightButton(_ sender: Any) {
        guard let counts = viewModel?.getImagesCount() else { return }
        if imageNumber != 0 {
            imageNumber -= 1
            collectionView.scrollToItem(at: IndexPath(row: imageNumber, section: 0), at: .left, animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath(row: counts - 1, section: 0), at: .left, animated: true)
            imageNumber = counts - 1
        }
    }
}
// MARK: - Collection View
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getImagesCount() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.Cells.main.rawValue, for: indexPath)
        guard let cell = cell as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel?.cellViewModel(forIndexPath: indexPath)
        collectionView.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

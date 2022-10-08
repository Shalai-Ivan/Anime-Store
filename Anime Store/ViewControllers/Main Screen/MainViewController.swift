//
//  MainViewController.swift
//  Anime Store
//
//  Created by MacMini on 6.10.22.
//

import UIKit

class MainViewController: UIViewController {
    var images: [UIImage] {
        Array(0...5).compactMap { UIImage(named: "item\($0)") }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func unwindSegueToMain(_ sender: UIStoryboardSegue) {
    }
}
// MARK: - Collection View
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.Cells.main.rawValue, for: indexPath)
        guard let cell = cell as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = images[indexPath.row]
        return cell
    }
}

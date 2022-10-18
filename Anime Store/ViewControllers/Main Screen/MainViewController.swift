//
//  MainViewController.swift
//  Anime Store
//
//  Created by MacMini on 6.10.22.
//

import AVKit
import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    @IBOutlet private weak var apiCollectionView: UICollectionView!
    @IBOutlet private weak var adminCollectionView: UICollectionView!
    @IBOutlet private weak var usersCollectionView: UICollectionView!
    @IBOutlet private weak var category1Label: UILabel!
    @IBOutlet private weak var category2Label: UILabel!
    @IBOutlet private weak var category3Label: UILabel!
    private var networkManager = NetworkManager()
    private var viewModel: MainViewModel?
    private let AVPLayerModel = AVPlayerModel()
    private var imageNumber: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        AVPLayerModel.playBackgroundVideo(forUrl: AVPLayerModel.mainBackgroundVideo, forView: self.view, speed: 0.8)
        startTimer()
    }
    deinit {
        AVPLayerModel.removeVideoPlayerObserver()
    }
    private func startTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(scrollCollectionViewForward), userInfo: nil, repeats: true)
    }
    @objc private func scrollCollectionViewForward() {
        guard let counts = viewModel?.getImagesCount(forTag: mainCollectionView.tag) else { return }
        if imageNumber < counts - 1 {
            imageNumber += 1
            mainCollectionView.scrollToItem(at: IndexPath(row: imageNumber, section: 0), at: .left, animated: true)
        } else {
            mainCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            imageNumber = 0
        }
    }
    private func scrollCollectionViewBack() {
        guard let counts = viewModel?.getImagesCount(forTag: mainCollectionView.tag) else { return }
        if imageNumber != 0 {
            imageNumber -= 1
            mainCollectionView.scrollToItem(at: IndexPath(row: imageNumber, section: 0), at: .left, animated: true)
        } else {
            mainCollectionView.scrollToItem(at: IndexPath(row: counts - 1, section: 0), at: .left, animated: true)
            imageNumber = counts - 1
        }
    }
    @IBAction private func unwindSegueToMain(_ sender: UIStoryboardSegue) {
    }
    @IBAction private func didTapToLeftButton(_ sender: Any) {
        scrollCollectionViewBack()
    }
    @IBAction private func didTapToRightButton(_ sender: Any) {
        scrollCollectionViewForward()
    }
}
// MARK: - CollectionView
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.getImagesCount(forTag: collectionView.tag) ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.Cells.main.rawValue, for: indexPath)
        guard let cell = cell as? MainCollectionViewCell, let viewModel = viewModel else { return UICollectionViewCell() }
        switch collectionView.tag {
        case 0:
            let animeName = viewModel.getAnimeName(forIndexPath: indexPath, forTag: collectionView.tag)
            DispatchQueue.main.async {
                self.networkManager.fetchRequest(typeRequest: .name(name: animeName)) { animeModels in
                    cell.animeModel = animeModels.first
                }
            }
            collectionView.layer.cornerRadius = 10
            collectionView.isScrollEnabled = false
            return cell
        case 1:
            DispatchQueue.main.async {
                self.networkManager.fetchRequest(typeRequest: .apiTop) { animeModels in
                    cell.animeModel = animeModels[indexPath.row]
                }
            }
            cell.layer.cornerRadius = 5
            collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
            return cell
        case 2,3:
            let animeName = viewModel.getAnimeName(forIndexPath: indexPath, forTag: collectionView.tag)
            DispatchQueue.main.async {
                self.networkManager.fetchRequest(typeRequest: .name(name: animeName)) { animeModels in
                    cell.animeModel = animeModels.first
                }
            }
            cell.layer.cornerRadius = 5
            collectionView.backgroundColor = UIColor(white: 0, alpha: 0)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: self.view.frame.width, height: collectionView.frame.height)
        default:
            let itemPerRow = 2
            let distanceBetweenRow = (itemPerRow + 1) * 5
            let widthPerRow = (Int(self.view.frame.width) - distanceBetweenRow) / itemPerRow
            return CGSize(width: CGFloat(widthPerRow), height: collectionView.frame.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 0:
            return 0
        default:
            return 5
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView.tag {
        case 0:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
}

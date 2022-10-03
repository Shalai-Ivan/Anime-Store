//
//  ViewController.swift
//  Anime Store
//
//  Created by MacMini on 3.10.22.
//

import AVKit
import UIKit

class RegistrationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
    }
    @objc private func repeatVideo(notification: Notification) {
        let playerItem = notification.object as? AVPlayerItem
        playerItem?.seek(to: .zero, completionHandler: nil)
    }
    private func playBackgroundVideo() {
        guard let url = Bundle.main.url(forResource: "backgroundVideo", withExtension: "mp4") else { return print("Error url") }
        let player = AVPlayer(url: url)
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.videoGravity = .resizeAspectFill
        player.actionAtItemEnd = .none
        videoLayer.frame = self.view.layer.bounds
        self.view.backgroundColor = .clear
        self.view.layer.insertSublayer(videoLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(repeatVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        player.play()
    }
}


//
//  AVPlayerModel.swift
//  Anime Store
//
//  Created by MacMini on 9.10.22.
//

import AVKit

class AVPlayerModel {
    let logInBackgroundVideo = "logInBackgroundVideo"
    let mainBackgroundVideo = "mainBackgroundVideo"
    func playBackgroundVideo(forUrl url: String, forView view: UIView, speed: Float) {
        guard let url = Bundle.main.url(forResource: url, withExtension: "mp4") else { return }
        let player = AVPlayer(url: url)
        let videoLayer = AVPlayerLayer(player: player)
        player.actionAtItemEnd = .none
        videoLayer.videoGravity = .resizeAspectFill
        videoLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(videoLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(repeatVideo(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        player.playImmediately(atRate: speed)
    }
    func removeVideoPlayerObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    @objc func repeatVideo(notification: Notification) {
        let playerItem = notification.object as? AVPlayerItem
        playerItem?.seek(to: .zero, completionHandler: nil)
    }
}

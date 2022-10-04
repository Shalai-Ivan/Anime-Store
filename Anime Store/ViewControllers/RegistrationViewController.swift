//
//  ViewController.swift
//  Anime Store
//
//  Created by MacMini on 3.10.22.
//

import AVKit
import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var registrationStackView: UIStackView!
    @IBOutlet private weak var signStackView: UIStackView!
    var isKeyboardAppear = false
    deinit {
        removeObservers()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackgroundVideo()
        interfaceSettings()
        registerForKeyboardNotification()
    }
    private func interfaceSettings() {
        loginTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc private func showKeyboard(notification: Notification) {
        guard let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= kbFrameSize.height / 2
        }
    }
    @objc private func hideKeyboard() {
        self.view.frame.origin.y = .zero
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
    @IBAction func tapViewGestureRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

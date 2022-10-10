//
//  ViewController.swift
//  Anime Store
//
//  Created by MacMini on 3.10.22.
//

import AVKit
import UIKit

final class LogInViewController: UIViewController {
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var registrationStackView: UIStackView!
    @IBOutlet private weak var signStackView: UIStackView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var loginRegistrationTextField: UITextField!
    @IBOutlet private weak var passwordRegistrationTextField: UITextField!
    @IBOutlet private weak var repeatPasswordRegistrationTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var telephoneNumberTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    private var nameFieldConstraint: NSLayoutConstraint!
    private var surnameFieldConstraint: NSLayoutConstraint!
    private var loginRegistrationFieldConstraint: NSLayoutConstraint!
    private var passwordRegistrationFieldConstraint: NSLayoutConstraint!
    private var repeatPasswordRegistrationFieldConstraint: NSLayoutConstraint!
    private var emailFieldConstraint: NSLayoutConstraint!
    private var telephoneNumberFieldConstraint: NSLayoutConstraint!
    private var registrationStackConstraint: NSLayoutConstraint!
    private let AVPLayerModel = AVPlayerModel()
    deinit {
        removeKeyboardObservers()
        AVPLayerModel.removeVideoPlayerObserver()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    }
    private func setupSettings() {
        AVPLayerModel.playBackgroundVideo(forUrl: AVPLayerModel.logInBackgroundVideo, forView: self.view, speed: 1)
        interfaceSettings()
        registerForKeyboardNotification()
        configurateRegistration()
    }
    
    // Registration Text Fields
    private func toHideTextFields(isHidden: Bool) {
        let constraints = [nameFieldConstraint, surnameFieldConstraint, loginRegistrationFieldConstraint, passwordRegistrationFieldConstraint, repeatPasswordRegistrationFieldConstraint, emailFieldConstraint, telephoneNumberFieldConstraint]
        for item in constraints {
            item?.isActive = isHidden
        }
        if isHidden {
            UIView.animate(withDuration: 0.8, delay: 0) { [weak self] in
                self?.signInButton.alpha = 1; self?.signInButton.isHidden = !isHidden
                self?.signUpButton.alpha = 1; self?.signUpButton.isHidden = !isHidden
                self?.registerButton.alpha = 0; self?.registerButton.isHidden = isHidden
                self?.cancelButton.alpha = 0; self?.cancelButton.isHidden = isHidden
            }
        } else {
            UIView.animate(withDuration: 0.8, delay: 0) { [weak self] in
                self?.signInButton.alpha = 0; self?.signInButton.isHidden = !isHidden
                self?.signUpButton.alpha = 0; self?.signUpButton.isHidden = !isHidden
                self?.registerButton.alpha = 1; self?.registerButton.isHidden = isHidden
                self?.cancelButton.alpha = 1; self?.cancelButton.isHidden = isHidden
            }
        }
        registrationStackConstraint.isActive = !isHidden
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    private func configurateRegistration() {
        nameFieldConstraint = nameTextField.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20)
        surnameFieldConstraint = surnameTextField.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        loginRegistrationFieldConstraint = loginRegistrationTextField.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20)
        passwordRegistrationFieldConstraint = passwordRegistrationTextField.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        repeatPasswordRegistrationFieldConstraint = repeatPasswordRegistrationTextField.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20)
        emailFieldConstraint = emailTextField.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        telephoneNumberFieldConstraint = telephoneNumberTextField.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20)
        registrationStackConstraint = registrationStackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        toHideTextFields(isHidden: true)
    }
    private func interfaceSettings() {
        loginTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        passwordTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        nameTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        surnameTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        loginRegistrationTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        passwordRegistrationTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        repeatPasswordRegistrationTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        emailTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
        telephoneNumberTextField.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    private func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func removeVideoPlayerObserver() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    // MARK: - @objc functions
    
    @objc private func showKeyboard(notification: Notification) {
        guard let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= kbFrameSize.height / 2
        }
    }
    @objc private func hideKeyboard() {
        self.view.frame.origin.y = .zero
    }
    
    // MARK: - @IBActions
    
    @IBAction private func tapViewGestureRecognizer(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func didTapSignInButton(_ sender: Any) {
        performSegue(withIdentifier: Identifiers.Segues.main.rawValue, sender: nil)
    }
    @IBAction func didTapSignUpButton(_ sender: Any) {
        toHideTextFields(isHidden: false)
    }
    @IBAction func didTapRegisterButton(_ sender: Any) {
        toHideTextFields(isHidden: true)
    }
    @IBAction func didTapCancelRegistrationButton(_ sender: Any) {
        toHideTextFields(isHidden: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

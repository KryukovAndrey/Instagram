//
//  LoginController.swift
//  Instagram
//
//  Created by Andrey Kryukov on 28.09.2022.
//

import UIKit
import Firebase

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

final class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.67), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstPart: "Forgot your password? ", secondPart: "Get help singing in.")
        button.addTarget(self, action: #selector(handleShowResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton()
        button.attributedTitle(firstPart: "Don't have an account? ", secondPart: "Sing Up")
        button.addTarget(self, action: #selector(handleShowSingUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNotificationObserers()
    }
    
    // MARK: - Actions
    
    @objc private func handleShowSingUp() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    @objc private func handleLogin() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to regiter user \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc private func handleShowResetPassword() {
        let controller = ResetPasswordController()
        controller.delegate = self
        controller.email = emailTextField.text
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureNotificationObserers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - FormViewModelProtocol

extension LoginController: FormViewModelProtocol {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}

// MARK: - ResetPasswordControllerDelegate

extension LoginController: ResetPasswordControllerDelegate {
    func controllerDidSendesetPasswordLink(_ controller: ResetPasswordController) {
        navigationController?.popViewController(animated: true)
        showMessage(withTitle: "Success", message: "We send a link to your email to reset your password")
    }
}

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [usernameField, passwordField, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        usernameField.placeholder = "Username"
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = false
        usernameField.autocapitalizationType = .none
        passwordField.autocapitalizationType = .none
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        view.addSubview(stackView)
        view.addSubview(loginButton)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func loginTapped() {
        guard let username = usernameField.text,
              let password = passwordField.text else { return }
        
        AuthService.shared.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("Uspješna prijava korisnika: \(user.name)")
                case .failure(let error):
                    self?.errorLabel.text = error.localizedDescription
                    self?.errorLabel.isHidden = false
                }
            }
        }
    }
}


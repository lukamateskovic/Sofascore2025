import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let errorLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupActions()
    }
    
    private func addViews() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(errorLabel)
        stackView.addArrangedSubview(loginButton)
        view.addSubview(stackView)
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        
        usernameField.placeholder = "Username"
        usernameField.autocapitalizationType = .none
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.autocapitalizationType = .none
        
        errorLabel.textColor = .red
        errorLabel.isHidden = true
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32)
        }
        usernameField.snp.makeConstraints { $0.height.equalTo(44) }
        passwordField.snp.makeConstraints { $0.height.equalTo(44) }
        loginButton.snp.makeConstraints { $0.height.equalTo(44) }
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
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


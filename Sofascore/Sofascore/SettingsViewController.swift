import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupDismissButton()
        
        title = "Settings"
    }
    
    private func setupDismissButton() {
        view.addSubview(dismissButton)
        
        dismissButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
}

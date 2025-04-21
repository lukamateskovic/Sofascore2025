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
        
        dismissButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(120) 
        }
    }
    
    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
}



//import UIKit
//import SofaAcademic
//import SnapKit
//
//class SettingsViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        title = "Settings"
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            title: "Dismiss",
//            style: .plain,
//            target: self,
//            action: #selector(dismissTapped)
//        )
//    }
//    
//    @objc private func dismissTapped() {
//        dismiss(animated: true)
//    }
//}

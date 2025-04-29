import UIKit
import SnapKit
import SofaAcademic

class HeaderView: BaseView {
    
    override func addViews() {
        addSubview(logoImageView)
        addSubview(settingsButton)
    }
    
    override func styleViews() {
        backgroundColor = .systemBlue
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(settingsButton.snp.leading).offset(-16)
        }
        
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    override func setupGestureRecognizers() {
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
    
    var onSettingsTapped: (() -> Void)?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sofascore_lockup"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = .white
        return button
    }()
}

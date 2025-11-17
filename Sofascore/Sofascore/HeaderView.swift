import UIKit
import SnapKit
import SofaAcademic

class HeaderView: BaseView {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "sofascore_lockup"))
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var onSettingsTapped: (() -> Void)?
    
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
            $0.width.equalTo(132)
        }
        
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(172)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(44).priority(.required)
        }
    }
    
    override func setupGestureRecognizers() {
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
}

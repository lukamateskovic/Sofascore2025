import UIKit
import SnapKit

class HeaderView: UIView {
    var onSettingsTapped: (() -> Void)?
    private let title: UILabel = .init()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = .systemBlue
        
        
        addSubview(logoImageView)
        addSubview(settingsButton)
        
        
        setupConstraints()
        
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.lessThanOrEqualTo(160) // prilagodi po potrebi
        }
    }
    
    @objc private func settingsTapped() {
        onSettingsTapped?()
    }
}

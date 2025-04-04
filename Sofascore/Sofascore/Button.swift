import UIKit
import SofaAcademic

class Button: BaseView {
    
    private var icon: UIImageView = .init()
    private var sports: UILabel = .init()

    var onTap: (() -> Void)?
    
    override func addViews() {
        addSubview(icon)
        addSubview(sports)
    }
    
    override func styleViews() {
        backgroundColor = .systemBlue
        
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .white
        
        sports.font = .roboto(size: 14, weight: .medium)
        sports.textColor = .white
        sports.textAlignment = .center
    }
    
    override func setupConstraints() {
        icon.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
            $0.size.equalTo(16)
        }
        
        sports.snp.makeConstraints{
            $0.top.equalTo(icon.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(4)
        }
    }
}

extension Button{
    func setIcon(_ image: UIImage?) {
        icon.image = image
    }
    func setSports(_ text: String?) {
        sports.text = text
    }
    
    @objc private func handleTap() {
        onTap?()
    }
    
    func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGestureRecognizer)
    }
}

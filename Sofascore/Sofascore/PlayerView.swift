import UIKit
import SnapKit
import SofaAcademic

final class PlayerView: BaseView {
    private let imageView: UIImageView = .init()
    private let nameLabel: UILabel = .init()
    private let countryStack: UIStackView = .init()
    private let flagLabel: UILabel = .init()
    private let countryLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(countryStack)
        countryStack.addArrangedSubview(flagLabel)
        countryStack.addArrangedSubview(countryLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        
        nameLabel.font = .roboto(size: 16, weight: .medium)
        nameLabel.textColor = .black
        
        countryStack.axis = .horizontal
        countryStack.spacing = 6
        countryStack.alignment = .center
        
        flagLabel.font = .systemFont(ofSize: 18)
        countryLabel.font = .roboto(size: 14)
        countryLabel.textColor = .gray
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.size.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.top.equalTo(imageView.snp.top).offset(2)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        countryStack.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.height.equalTo(20)
        }
    }
    
    func configure(name: String, country: String, imageUrl: String?) {
        nameLabel.text = name
        countryLabel.text = country
        imageView.load(urlString: imageUrl)
    }
    
    func configure(with manager: TeamManager) {
        configure(
            name: manager.name,
            country: manager.country.name,
            imageUrl: manager.imageUrl
        )
    }
    
}


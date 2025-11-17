import UIKit
import SnapKit
import SofaAcademic

final class EventTitleView: BaseView {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    override func addViews() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }
    
    override func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
    }
    
    override func setupConstraints() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
        imageView.snp.makeConstraints { $0.width.height.equalTo(32) }
    }
    
    func configure(
        sportName: String,
        countryName: String,
        leagueName: String,
        roundInfo: String,
        logoUrl: String?
    ) {
        imageView.load(urlString: logoUrl)
        titleLabel.text = "\(sportName), \(countryName), \(leagueName), \(roundInfo)"
    }
}



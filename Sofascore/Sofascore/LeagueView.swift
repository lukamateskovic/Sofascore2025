import UIKit
import SnapKit
import SofaAcademic

final class LeagueView: BaseView {
    
    private let logoImageView: UIImageView = .init()
    private let countryLabel: UILabel = .init()
    private let pointer: UIImageView = .init()
    private let leagueLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(pointer)
        addSubview(leagueLabel)
    }
    
    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        
        countryLabel.font = .roboto(size: 14, weight: .bold)
        
        pointer.contentMode = .scaleAspectFit
        
        leagueLabel.font = .roboto(size: 14, weight: .bold)
        leagueLabel.textColor = .gray
    }
    
    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.size.equalTo(32)
        }
        countryLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
        }
        countryLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        pointer.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(countryLabel.snp.trailing).offset(7)
            $0.width.equalTo(10)
            $0.height.equalTo(10)
        }
        leagueLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(pointer.snp.trailing).offset(7)
            $0.height.equalTo(16)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
        leagueLabel.setContentHuggingPriority(.required, for: .horizontal)
        leagueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}

extension LeagueView {

    func setleagueLogoImage(_ image: UIImage?) {
        logoImageView.image = image
    }
    func setCountryLabel(_ text: String?) {
        countryLabel.text = text
    }
    func setPointerImage() {
        pointer.image = UIImage(named: "pointer")
    }
    func setLeagueLabel(_ text: String?) {
        leagueLabel.text = text
    }
}


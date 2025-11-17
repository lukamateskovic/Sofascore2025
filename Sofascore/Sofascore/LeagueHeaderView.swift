import UIKit
import SnapKit
import SofaAcademic

final class LeagueHeaderView: BaseView {
    private let leagueImageView: UIImageView = .init()
    private let leagueNameLabel: UILabel = .init()
    private let countryLabel: UILabel = .init()
    
    private var isCollapsed = false
    
    override func addViews() {
        addSubview(leagueImageView)
        addSubview(leagueNameLabel)
        addSubview(countryLabel)
    }
    
    override func styleViews() {
        backgroundColor = .systemBlue
        
        leagueImageView.contentMode = .scaleAspectFit
        leagueImageView.layer.cornerRadius = 8
        leagueImageView.clipsToBounds = true
        
        leagueNameLabel.font = .roboto(size: 24,weight: .bold)
        leagueNameLabel.textColor = .white
        
        countryLabel.font = .roboto(size: 16)
        countryLabel.textColor = .white
    }
    
    override func setupConstraints() {
        leagueImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(56)
        }
        
        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueImageView.snp.trailing).offset(16)
            $0.top.equalTo(leagueImageView).offset(8)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueNameLabel)
            $0.top.equalTo(leagueNameLabel.snp.bottom).offset(4)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func configure(with league: League) {
        leagueNameLabel.text = league.name
        countryLabel.text = "\(league.country.name)"
        leagueImageView.load(urlString: league.logoUrl)
    }
    
    func setCollapsed(_ collapsed: Bool, animated: Bool = true) {
        guard isCollapsed != collapsed else { return }
        isCollapsed = collapsed
        
        let duration = animated ? 0.3 : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            if collapsed {
                self.leagueImageView.alpha = 0
                self.countryLabel.alpha = 0
                self.leagueNameLabel.font = .roboto(size: 20, weight: .bold)
                
                self.leagueNameLabel.snp.remakeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.centerX.equalToSuperview()
                    $0.leading.greaterThanOrEqualToSuperview().offset(16)
                    $0.trailing.lessThanOrEqualToSuperview().offset(-16)
                }
            } else {
                self.leagueImageView.alpha = 1
                self.countryLabel.alpha = 1
                self.leagueNameLabel.font = .roboto(size: 24, weight: .bold)
                
                self.leagueNameLabel.snp.remakeConstraints {
                    $0.leading.equalTo(self.leagueImageView.snp.trailing).offset(12)
                    $0.centerY.equalToSuperview().offset(-8)
                    $0.trailing.lessThanOrEqualToSuperview().offset(-16)
                }
            }
            self.layoutIfNeeded()
        }
    }
}

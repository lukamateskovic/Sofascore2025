import UIKit
import SnapKit
import SofaAcademic

final class TeamHeaderView: BaseView {
    private let teamImageView: UIImageView = .init()
    private let teamNameLabel: UILabel = .init()
    private let countryLabel: UILabel = .init()
    
    private var isCollapsed = false
    
    
    override func addViews() {
        addSubview(teamImageView)
        addSubview(teamNameLabel)
        addSubview(countryLabel)
    }
    
    override func styleViews() {
        backgroundColor = .systemBlue
        
        teamImageView.contentMode = .scaleAspectFit
        teamImageView.layer.cornerRadius = 8
        teamImageView.clipsToBounds = true
        
        teamNameLabel.font = .roboto(size: 24, weight: .bold)
        teamNameLabel.textColor = .white
        
        countryLabel.font = .roboto(size: 16)
        countryLabel.textColor = .white
    }
    
    override func setupConstraints() {
        teamImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(56)
        }
        
        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamImageView.snp.trailing).offset(16)
            $0.top.equalTo(teamImageView).offset(8)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(teamNameLabel)
            $0.top.equalTo(teamNameLabel.snp.bottom).offset(4)
        }
    }
    
    func configure(with team: TeamDetail) {
        teamNameLabel.text = team.name
        countryLabel.text = team.country.name
        teamImageView.load(urlString: team.logoUrl)
    }
    
    func setCollapsed(_ collapsed: Bool, animated: Bool = true) {
        guard isCollapsed != collapsed else { return }
        isCollapsed = collapsed
        
        let duration = animated ? 0.3 : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut) {
            if collapsed {
                self.teamImageView.alpha = 0
                self.countryLabel.alpha = 0
                self.teamNameLabel.font = .roboto(size: 20, weight: .bold)
                
                self.teamNameLabel.snp.remakeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.centerX.equalToSuperview()
                    $0.leading.greaterThanOrEqualToSuperview().offset(16)
                    $0.trailing.lessThanOrEqualToSuperview().offset(-16)
                }
            } else {
                self.teamImageView.alpha = 1
                self.countryLabel.alpha = 1
                self.teamNameLabel.font = .roboto(size: 24, weight: .bold)
                
                self.teamNameLabel.snp.remakeConstraints {
                    $0.leading.equalTo(self.teamImageView.snp.trailing).offset(12)
                    $0.centerY.equalToSuperview().offset(-8)
                    $0.trailing.lessThanOrEqualToSuperview().offset(-16)
                }
            }
            self.layoutIfNeeded()
        }
    }
}

import UIKit
import SnapKit
import SofaAcademic

final class AmericanFootballIncidentView: BaseView {
    
    private let iconImageView: UIImageView = .init()
    private let minuteLabel: UILabel = .init()
    private let playerLabel: UILabel = .init()
    private let scoreLabel: UILabel = .init()
    private let indicator: UIView = .init()
    private let periodEndContainer: UIView = .init()
    private let periodEndLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(indicator)
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(playerLabel)
        addSubview(scoreLabel)
        addSubview(periodEndContainer)
        periodEndContainer.addSubview(periodEndLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        
        indicator.backgroundColor = .systemGray
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemGreen
        
        minuteLabel.font = .roboto(size: 12, weight: .medium)
        minuteLabel.textColor = .gray
        
        playerLabel.font = .roboto(size: 14, weight: .medium)
        playerLabel.textColor = .black
        
        scoreLabel.font = .roboto(size: 20, weight: .bold)
        scoreLabel.textColor = .black
        
        periodEndContainer.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.92, alpha: 1)
        periodEndContainer.layer.cornerRadius = 24
        periodEndContainer.clipsToBounds = true
        
        periodEndLabel.font = .roboto(size: 12, weight: .bold)
        periodEndLabel.textColor = .black
        periodEndLabel.textAlignment = .center
        
        scoreLabel.textAlignment = .center
        playerLabel.textAlignment = .right
        minuteLabel.textAlignment = .center
    }
    
    private func setupPeriodEndLayout() {
        periodEndContainer.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        periodEndLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupHomeTeamGoalLayout() {
        removeAllConstraints()
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(40)
        }
        
        indicator.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(17)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(indicator.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(68)
        }
        
        playerLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualTo(188).priority(.high)
            $0.leading.equalTo(scoreLabel.snp.trailing).offset(28)
            $0.height.equalTo(16)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setupAwayTeamGoalLayout() {
        removeAllConstraints()
        
        scoreLabel.textAlignment = .center
        playerLabel.textAlignment = .right
        minuteLabel.textAlignment = .center
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(indicator.snp.trailing).offset(17)
            $0.trailing.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.leading.equalTo(indicator.snp.trailing).offset(7)
        }
        
        indicator.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(playerLabel.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(68)
        }
        
        playerLabel.snp.makeConstraints {
            $0.leading.lessThanOrEqualToSuperview().inset(16)
            $0.width.lessThanOrEqualTo(188).priority(.high)
            $0.top.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func removeAllConstraints() {
        indicator.snp.removeConstraints()
        iconImageView.snp.removeConstraints()
        minuteLabel.snp.removeConstraints()
        playerLabel.snp.removeConstraints()
        scoreLabel.snp.removeConstraints()
    }
    
    func configure(minute: String, player: String, score: String,description: String, isHomeTeam: Bool, icon: UIImage?, incidentType: IncidentType) {
        removeAllConstraints()
        
        minuteLabel.text = minute
        playerLabel.text = player
        scoreLabel.text = score
        iconImageView.image = icon
        
        if incidentType == .periodEnd {
            setupPeriodEndLayout()
            periodEndLabel.text = description + " (" + score + ")"
        } else if isHomeTeam {
            setupHomeTeamGoalLayout()
        } else {
            setupAwayTeamGoalLayout()
        }
    }
}

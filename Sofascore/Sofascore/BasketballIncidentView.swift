import UIKit
import SnapKit
import SofaAcademic

struct BasketballIncidentDisplayModel {
    let incident: Incident
    let homeScore: Int
    let awayScore: Int
}

final class BasketballIncidentView: BaseView {
    
    private let iconImageView: UIImageView = .init()
    private let minuteLabel: UILabel = .init()
    private let scoreLabel: UILabel = .init()
    private let indicator: UIView = .init()
    
    private let periodEndContainer: UIView = .init()
    private let periodEndLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(indicator)
        addSubview(iconImageView)
        addSubview(minuteLabel)
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
    
        scoreLabel.font = .roboto(size: 14, weight: .bold)
        scoreLabel.textColor = .black
        
        periodEndContainer.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.92, alpha: 1)
        periodEndContainer.layer.cornerRadius = 24
        periodEndContainer.clipsToBounds = true
            
        periodEndLabel.font = .roboto(size: 12, weight: .bold)
        periodEndLabel.textColor = .black
        periodEndLabel.textAlignment = .center
        
        scoreLabel.textAlignment = .center
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
            $0.bottom.equalToSuperview().offset(-10)
            $0.size.equalTo(20).priority(.high)
        }
        
        indicator.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(17)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing).offset(28)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.lessThanOrEqualToSuperview().offset(-168)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(indicator.snp.trailing).offset(4)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(80)
        }
        
    }
    
    private func setupAwayTeamGoalLayout() {
        removeAllConstraints()
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalTo(indicator.snp.trailing).offset(17)
            $0.trailing.equalToSuperview().inset(18)
            $0.top.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(20)
        }
        
        minuteLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(168)
            $0.bottom.top.equalToSuperview().inset(12)
            $0.width.equalTo(24)
        }
        
        indicator.snp.makeConstraints {
            $0.leading.equalTo(scoreLabel.snp.trailing).inset(4)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(minuteLabel.snp.trailing).offset(28)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.lessThanOrEqualTo(80).priority(.high)
        }
    }
    
    private func removeAllConstraints() {
        indicator.snp.removeConstraints()
        iconImageView.snp.removeConstraints()
        minuteLabel.snp.removeConstraints()
        scoreLabel.snp.removeConstraints()
    }
    
    func configure(icon: UIImage?, action: String, minute: String, score: String, isHomeTeam: Bool, incidentType: IncidentType) {
        
        removeAllConstraints()
        
        iconImageView.image = icon
        
        minuteLabel.text = minute
        scoreLabel.text = score
        
        if incidentType == .periodEnd{
            setupPeriodEndLayout()
            periodEndLabel.text = action
        } else if isHomeTeam && incidentType == .goal{
            setupHomeTeamGoalLayout()
        } else {
            setupAwayTeamGoalLayout()
        }
    }
}


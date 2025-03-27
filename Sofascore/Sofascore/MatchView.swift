import UIKit
import SnapKit
import SofaAcademic

final class MatchView: BaseView {
    
    private let startTimeLabel: UILabel = .init()
    private let timeLabel: UILabel = .init()
    private let line: UIView = .init()
    private let homeTeamImageView: UIImageView = .init()
    private let homeTeamLabel: UILabel = .init()
    private let awayTeamImageView: UIImageView = .init()
    private let awayTeamLabel: UILabel = .init()
    private let homeScoreLabel: UILabel = .init()
    private let awayScoreLabel: UILabel = .init()
    
    override func addViews() {
        addSubview(startTimeLabel)
        addSubview(timeLabel)
        addSubview(line)
        addSubview(homeTeamImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamImageView)
        addSubview(awayTeamLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }
    
    override func styleViews() {
        startTimeLabel.font = .roboto(size: 12, weight: .medium)
        startTimeLabel.textColor = .gray
        startTimeLabel.textAlignment = .center
        
        timeLabel.font = .roboto(size: 12, weight: .medium)
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .center
        
        line.backgroundColor = .lightGray
        line.contentMode = .scaleAspectFit
        
        homeTeamImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = .roboto(size: 14, weight: .medium)
        
        
        awayTeamImageView.contentMode = .scaleAspectFit
        
        awayTeamLabel.font = .roboto(size: 14, weight: .medium)
        
        homeScoreLabel.font = .roboto(size: 14, weight: .medium)
        homeScoreLabel.textColor = .black
        homeScoreLabel.textAlignment = .center
        
        awayScoreLabel.font = .roboto(size: 14, weight: .medium)
        awayScoreLabel.textColor = .black
        awayScoreLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        startTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(4)
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(56)
            $0.height.equalTo(16)
        }
        
        timeLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(4)
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(4)
            $0.width.equalTo(56)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        line.snp.makeConstraints{
            $0.leading.equalTo(startTimeLabel.snp.trailing).offset(3)
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(1)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        homeTeamImageView.snp.makeConstraints {
            $0.leading.equalTo(line.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        homeTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(homeTeamImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualTo(homeScoreLabel.snp.leading).offset(-8)
        }
        homeTeamLabel.setContentHuggingPriority(.required, for: .horizontal)
        homeTeamLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        awayTeamImageView.snp.makeConstraints {
            $0.leading.equalTo(line.snp.trailing).offset(16)
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            $0.trailing.lessThanOrEqualTo(awayScoreLabel.snp.leading).offset(-8)
        }
        awayTeamLabel.setContentHuggingPriority(.required, for: .horizontal)
        awayTeamLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(homeScoreLabel.snp.bottom).offset(10)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
    }
}

extension MatchView {

    func setStartTimeLabel(_ text: String?) {
        startTimeLabel.text = text
    }
    func setTimeLabel(_ text: String?) {
        timeLabel.text = text
    }
    func setTimeLabelColor(_ color: UIColor) {
            timeLabel.textColor = color
    }
    func setHomeTeamImage(_ image: UIImage?) {
        homeTeamImageView.image = image
    }
    func setHomeTeamLabel(_ text: String?) {
        homeTeamLabel.text = text
    }
    func setHomeTeamLabelColor(_ color: UIColor) {
            homeTeamLabel.textColor = color
    }
    func setAwayTeamImage(_ image: UIImage?) {
        awayTeamImageView.image = image
    }
    func setAwayTeamLabel(_ text: String?) {
        awayTeamLabel.text = text
    }
    func setAwayTeamLabelColor(_ color: UIColor) {
            awayTeamLabel.textColor = color
    }
    func setHomeScoreLabel(_ text: String?) {
        homeScoreLabel.text = text
    }
    func setHomeScoreLabelColor(_ color: UIColor) {
        homeScoreLabel.textColor = color
    }
    func setAwayScoreLabel(_ text: String?) {
        awayScoreLabel.text = text
    }
    func setAwayScoreLabelColor(_ color: UIColor) {
        awayScoreLabel.textColor = color
    }
}

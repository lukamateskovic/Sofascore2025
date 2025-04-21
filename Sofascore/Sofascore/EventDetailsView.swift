import UIKit
import SnapKit
import SofaAcademic

final class EventDetailsView: BaseView {
    
    private let homeTeamImageView: UIImageView = .init()
    private let homeTeamLabel: UILabel = .init()
    private let awayTeamImageView: UIImageView = .init()
    private let awayTeamLabel: UILabel = .init()
    
    private let homeScoreLabel: UILabel = .init()
    private let scoreSeparatorLabel: UILabel = .init()
    private let awayScoreLabel: UILabel = .init()
    
    private let statusLabel: UILabel = .init()
    private let dateLabel: UILabel = .init()
    private let timeLabel: UILabel = .init()
    
    override func addViews() {

        addSubview(homeTeamImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamImageView)
        addSubview(awayTeamLabel)
        
        addSubview(homeScoreLabel)
        addSubview(scoreSeparatorLabel)
        addSubview(awayScoreLabel)
        
        addSubview(statusLabel)
        addSubview(dateLabel)
        addSubview(timeLabel)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        homeTeamImageView.contentMode = .scaleAspectFit
        awayTeamImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = .roboto(size: 12, weight: .bold)
        homeTeamLabel.textAlignment = .center
        homeTeamLabel.numberOfLines = 2
        
        awayTeamLabel.font = .roboto(size: 12, weight: .bold)
        awayTeamLabel.textAlignment = .center
        awayTeamLabel.numberOfLines = 2
        
        homeScoreLabel.font = .roboto(size: 32, weight: .bold)
        homeScoreLabel.textAlignment = .right
        
        scoreSeparatorLabel.font = .roboto(size: 32, weight: .bold)
        scoreSeparatorLabel.text = "-"
        scoreSeparatorLabel.textAlignment = .center
        
        awayScoreLabel.font = .roboto(size: 32, weight: .bold)
        awayScoreLabel.textAlignment = .left
        
        statusLabel.font = .roboto(size: 12, weight: .black)
        statusLabel.textAlignment = .center
        
        dateLabel.font = .roboto(size: 12, weight: .black)
        dateLabel.textAlignment = .center
        
        timeLabel.font = .roboto(size: 12, weight: .black)
        timeLabel.textAlignment = .center
    }
    
    override func setupConstraints() {
        
        homeTeamImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(44)
            $0.top.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        
        homeTeamLabel.snp.makeConstraints {
            $0.centerX.equalTo(homeTeamImageView.snp.centerX)
            $0.bottom.equalToSuperview().inset(16)
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(8)
            $0.width.equalTo(96)
        }
        homeTeamLabel.setContentHuggingPriority(.required, for: .horizontal)
        homeTeamLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        awayTeamImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(44)
            $0.size.equalTo(40)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.centerX.equalTo(awayTeamImageView.snp.centerX)
            $0.top.equalTo(awayTeamImageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(96)
        }
        awayTeamLabel.setContentHuggingPriority(.required, for: .horizontal)
        awayTeamLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalTo(scoreSeparatorLabel.snp.leading).offset(-4)
            $0.centerY.equalTo(homeTeamImageView.snp.centerY)
            $0.width.equalTo(56)
        }
        
        scoreSeparatorLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeTeamImageView.snp.centerY)
            $0.width.equalTo(16)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.leading.equalTo(scoreSeparatorLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(homeTeamImageView.snp.centerY)
            $0.width.equalTo(56)
        }
        
        statusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreSeparatorLabel.snp.bottom).offset(4)
            $0.width.equalTo(136)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeTeamImageView.snp.centerY)
            $0.width.equalTo(136)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.width.equalTo(136)
        }
    }
    
    func configure(with event: Event) {

        setHomeTeamImage(UIImage(named: event.homeTeam.name.lowercased()))
        setHomeTeamLabel(event.homeTeam.name)
        
        setAwayTeamImage(UIImage(named: event.awayTeam.name.lowercased()))
        setAwayTeamLabel(event.awayTeam.name)
        
        switch event.status {
        case .notStarted:
            configureForUpcomingMatch(event)
        case .inProgress:
            configureForInProgressMatch(event)
        default:
            configureForFinishedMatch(event)
        }
    }
    
    private func configureForUpcomingMatch(_ event: Event) {

        homeScoreLabel.isHidden = true
        scoreSeparatorLabel.isHidden = true
        awayScoreLabel.isHidden = true
        statusLabel.isHidden = true
        dateLabel.isHidden = false
        timeLabel.isHidden = false
        
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy."
        dateLabel.text = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: date)
    }

    private func configureForInProgressMatch(_ event: Event) {

        homeScoreLabel.isHidden = false
        scoreSeparatorLabel.isHidden = false
        awayScoreLabel.isHidden = false
        statusLabel.isHidden = false
        dateLabel.isHidden = true
        timeLabel.isHidden = true
        
        homeScoreLabel.text = event.homeScore != nil ? "\(event.homeScore!)" : "0"
        homeScoreLabel.textColor = .systemRed
        scoreSeparatorLabel.textColor = .systemRed
        awayScoreLabel.text = event.awayScore != nil ? "\(event.awayScore!)" : "0"
        awayScoreLabel.textColor = .systemRed
        
        let currentTime = Date()
        let startTime = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let minutesPassed = Int(currentTime.timeIntervalSince(startTime) / 60)
        
        statusLabel.text = "\(minutesPassed)'"
        statusLabel.textColor = .systemRed
    }
    

    private func configureForFinishedMatch(_ event: Event) {

        homeScoreLabel.isHidden = false
        scoreSeparatorLabel.isHidden = false
        awayScoreLabel.isHidden = false
        statusLabel.isHidden = false
        dateLabel.isHidden = true
        timeLabel.isHidden = true
        
        let homescore = event.homeScore != nil ? "\(event.homeScore!)" : "0"
        let awayScore = event.awayScore != nil ? "\(event.awayScore!)" : "0"
        
        homeScoreLabel.text = homescore
        homeScoreLabel.textColor = .gray
        scoreSeparatorLabel.textColor = .gray
        awayScoreLabel.text = awayScore
        awayScoreLabel.textColor = .gray
        
        if(homescore > awayScore) {
            homeScoreLabel.textColor = .black
        } else {
            awayScoreLabel.textColor = .black
        }
        
        statusLabel.text = "Full Time"
        statusLabel.textColor = .gray
    }
}

extension EventDetailsView {
    func setHomeTeamImage(_ image: UIImage?) {
        homeTeamImageView.image = image
    }
    
    func setHomeTeamLabel(_ text: String?) {
        homeTeamLabel.text = text
    }
    
    func setAwayTeamImage(_ image: UIImage?) {
        awayTeamImageView.image = image
    }
    
    func setAwayTeamLabel(_ text: String?) {
        awayTeamLabel.text = text
    }
}

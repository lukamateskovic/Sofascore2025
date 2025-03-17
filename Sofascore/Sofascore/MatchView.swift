import UIKit
import SnapKit
import SofaAcademic

final class MatchView: BaseView {
    
    var startTimeLabel: UILabel!
    var timeLabel: UILabel!
    var line: UIImageView!
    var homeTeamImageView: UIImageView!
    var homeTeamLabel: UILabel!
    var awayTeamImageView: UIImageView!
    var awayTeamLabel: UILabel!
    var scoreLabelHome: UILabel!
    var scoreLabelAway: UILabel!
    
    override func addViews() {
        startTimeLabel = UILabel()
        timeLabel = UILabel()
        line = UIImageView()
        homeTeamImageView = UIImageView()
        homeTeamLabel = UILabel()
        awayTeamImageView = UIImageView()
        awayTeamLabel = UILabel()
        scoreLabelHome = UILabel()
        scoreLabelAway = UILabel()
        
        
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false
        homeTeamImageView.translatesAutoresizingMaskIntoConstraints = false
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamImageView.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabelHome.translatesAutoresizingMaskIntoConstraints = false
        scoreLabelAway.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(startTimeLabel)
        addSubview(timeLabel)
        addSubview(line)
        addSubview(homeTeamImageView)
        addSubview(homeTeamLabel)
        addSubview(awayTeamImageView)
        addSubview(awayTeamLabel)
        addSubview(scoreLabelHome)
        addSubview(scoreLabelAway)
    }
    
    override func styleViews() {
        startTimeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        startTimeLabel.textColor = .gray
        startTimeLabel.textAlignment = .center
        
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .center
        
        line.backgroundColor = .lightGray
        line.contentMode = .scaleAspectFit
        
        homeTeamImageView.contentMode = .scaleAspectFit
        
        homeTeamLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        
        awayTeamImageView.contentMode = .scaleAspectFit
        
        awayTeamLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        scoreLabelHome.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        scoreLabelHome.textColor = .black
        scoreLabelHome.textAlignment = .center
        
        scoreLabelAway.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        scoreLabelAway.textColor = .black
        scoreLabelAway.textAlignment = .center
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
            $0.height.equalTo(16)
        }
        
        line.snp.makeConstraints{
            $0.leading.equalTo(startTimeLabel.snp.trailing).offset(3)
            $0.top.equalToSuperview().inset(8)
            $0.width.equalTo(1)
            $0.height.equalTo(40)
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
            $0.width.equalTo(192)
            $0.height.equalTo(16)
        }
        
        awayTeamImageView.snp.makeConstraints {
            $0.leading.equalTo(line.snp.trailing).offset(16)
            $0.top.equalTo(homeTeamImageView.snp.bottom).offset(4)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        awayTeamLabel.snp.makeConstraints {
            $0.leading.equalTo(awayTeamImageView.snp.trailing).offset(8)
            $0.top.equalTo(homeTeamLabel.snp.bottom).offset(4)
            $0.width.equalTo(192)
            $0.height.equalTo(16)
        }
        
        scoreLabelHome.snp.makeConstraints {
            $0.leading.equalTo(homeTeamLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
        scoreLabelAway.snp.makeConstraints {
            $0.leading.equalTo(awayTeamLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(scoreLabelHome.snp.bottom).offset(10)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
    }
    
    
}


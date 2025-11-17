import UIKit
import SnapKit
import SofaAcademic

final class StandingsFootballView: BaseView {
    private let positionLabel: UILabel = .init()
    private let teamLabel: UILabel = .init()
    private let playedLabel: UILabel = .init()
    private let wonLabel: UILabel = .init()
    private let drawLabel: UILabel = .init()
    private let lostLabel: UILabel = .init()
    private let goalsLabel: UILabel = .init()
    private let pointsLabel: UILabel = .init()
    var onTeamTap: (() -> Void)?
    
    override func addViews() {
        [positionLabel, teamLabel, playedLabel, wonLabel, drawLabel, lostLabel, goalsLabel, pointsLabel].forEach {
            addSubview($0)
        }
        teamLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(teamTapped))
        teamLabel.addGestureRecognizer(tap)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        [positionLabel, teamLabel, playedLabel, wonLabel, drawLabel, lostLabel, goalsLabel, pointsLabel].forEach {
            $0.font = .roboto(size: 14)
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        teamLabel.textAlignment = .left
        positionLabel.font = .roboto(size: 14, weight: .medium)
        positionLabel.layer.cornerRadius = 12
        positionLabel.clipsToBounds = true
        positionLabel.backgroundColor = UIColor(red: 0xF0/255.0, green: 0xEE/255.0, blue: 0xDF/255.0, alpha: 1.0)
        teamLabel.font = .roboto(size: 14, weight: .medium)
        pointsLabel.font = .roboto(size: 14, weight: .medium)
    }
    
    override func setupConstraints() {
        positionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        teamLabel.snp.makeConstraints {
            $0.leading.equalTo(positionLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(104)
        }
        
        playedLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        wonLabel.snp.makeConstraints {
            $0.leading.equalTo(playedLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        drawLabel.snp.makeConstraints {
            $0.leading.equalTo(wonLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        lostLabel.snp.makeConstraints {
            $0.leading.equalTo(drawLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        goalsLabel.snp.makeConstraints {
            $0.leading.equalTo(lostLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        pointsLabel.snp.makeConstraints {
            $0.leading.equalTo(goalsLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(position: String, team: String, played: String, won: String, draw: String, lost: String, goals: String, points: String, highlightPosition: Int)
    {
        positionLabel.text = position
        teamLabel.text = team
        playedLabel.text = played
        wonLabel.text = won
        drawLabel.text = draw
        lostLabel.text = lost
        goalsLabel.text = goals
        pointsLabel.text = points
    }
    
    @objc private func teamTapped() {
        onTeamTap?()
    }
}


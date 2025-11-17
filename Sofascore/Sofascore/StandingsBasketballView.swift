import UIKit
import SnapKit
import SofaAcademic

final class StandingsBasketballView: BaseView {
    private let positionLabel: UILabel = .init()
    private let teamLabel: UILabel = .init()
    private let playedLabel: UILabel = .init()
    private let wonLabel: UILabel = .init()
    private let lostLabel: UILabel = .init()
    private let diffLabel: UILabel = .init()
    private let strLabel: UILabel = .init()
    private let gbLabel: UILabel = .init()
    private let pctLabel: UILabel = .init()
    var onTeamTap: (() -> Void)?
    
    override func addViews() {
        [positionLabel, teamLabel, playedLabel, wonLabel, lostLabel, diffLabel, strLabel, gbLabel, pctLabel].forEach {
            addSubview($0)
        }
        teamLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(teamTapped))
        teamLabel.addGestureRecognizer(tap)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        [positionLabel, teamLabel, playedLabel, wonLabel, lostLabel, diffLabel, strLabel, gbLabel, pctLabel].forEach {
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
        pctLabel.font = .roboto(size: 14, weight: .bold)
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
            $0.width.equalTo(80)
        }
        
        playedLabel.snp.makeConstraints {
            $0.leading.equalTo(teamLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        wonLabel.snp.makeConstraints {
            $0.leading.equalTo(playedLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        lostLabel.snp.makeConstraints {
            $0.leading.equalTo(wonLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        diffLabel.snp.makeConstraints {
            $0.leading.equalTo(lostLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(32)
        }
        
        strLabel.snp.makeConstraints {
            $0.leading.equalTo(diffLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }
        
        gbLabel.snp.makeConstraints {
            $0.leading.equalTo(strLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(32)
        }
        
        pctLabel.snp.makeConstraints {
            $0.leading.equalTo(gbLabel.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(position: String, team: String, played: String, won: String, lost: String, diff: String, str: String, gb: String, pct: String, highlightPosition: Int)
    {
        positionLabel.text = position
        teamLabel.text = team
        playedLabel.text = played
        wonLabel.text = won
        lostLabel.text = lost
        diffLabel.text = diff
        strLabel.text = str
        gbLabel.text = gb
        pctLabel.text = pct
    }
    
    @objc private func teamTapped() {
        onTeamTap?()
    }
}



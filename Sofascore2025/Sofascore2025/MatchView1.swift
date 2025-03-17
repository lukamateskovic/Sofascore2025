import UIKit
import SofaAcademic
import SnapKit

class MatchView1: BaseView {

    private let homeTeamLabel = UILabel()
    private let awayTeamLabel = UILabel()
    private let scoreLabel = UILabel()

    override func addViews() {
        addSubview(homeTeamLabel)
        addSubview(awayTeamLabel)
        addSubview(scoreLabel)
    }

    override func styleViews() {
        homeTeamLabel.font = Fonts.titleFont
        awayTeamLabel.font = Fonts.titleFont
        scoreLabel.font = Fonts.subtitleFont

        homeTeamLabel.textColor = Colors.primaryTextColor
        awayTeamLabel.textColor = Colors.primaryTextColor
        scoreLabel.textColor = Colors.secondaryTextColor
    }

    override func setupConstraints() {
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        awayTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeTeamLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            homeTeamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            awayTeamLabel.topAnchor.constraint(equalTo: homeTeamLabel.bottomAnchor, constant: 8),
            awayTeamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    func configure(with event: Event) {
        homeTeamLabel.text = event.homeTeam.name
        awayTeamLabel.text = event.awayTeam.name

        if let homeScore = event.homeScore, let awayScore = event.awayScore {
            scoreLabel.text = "\(homeScore) - \(awayScore)"
        } else {
            scoreLabel.text = "N/A"
        }
    }
}

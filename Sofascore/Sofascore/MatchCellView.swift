import UIKit
import SnapKit
import SofaAcademic

class MatchViewCell: UITableViewCell, ReusableCell, CellConfigurable {

    private let matchView = MatchView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(matchView)
    }
    
    private func setupConstraints() {
        matchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MatchViewCell{
    
    func configure(with model: Any) {
        guard let event = model as? Event else {
            fatalError("")
        }
        configureCell(event: event)
    }
    
    private func configureCell(event: Event) {

        matchView.setStartTimeLabel(EventHelper.formatStartTime(for: event))
        matchView.setTimeLabel(EventHelper.getTimeDescription(for: event))
        matchView.setTimeLabelColor(EventHelper.getTimeColor(for: event))
            
        configureTeamViews(event: event, isHomeTeam: true)
        configureTeamViews(event: event, isHomeTeam: false)
            
        configureScores(event: event)
    }
    
    private func configureTeamViews(event: Event, isHomeTeam: Bool) {
        let team = isHomeTeam ? event.homeTeam : event.awayTeam
        let color = EventHelper.getTeamColor(for: event, isHomeTeam: isHomeTeam)
            
        if isHomeTeam {
            matchView.setHomeTeamImage(UIImage(named: team.name.lowercased()))
            matchView.setHomeTeamLabel(team.name)
            matchView.setHomeTeamLabelColor(color)
        } else {
            matchView.setAwayTeamImage(UIImage(named: team.name.lowercased()))
            matchView.setAwayTeamLabel(team.name)
            matchView.setAwayTeamLabelColor(color)
        }
    }
    
    private func configureScores(event: Event) {
        let homeScore = event.homeScore != nil ? String(event.homeScore!) : ""
        let awayScore = event.awayScore != nil ? String(event.awayScore!) : ""
            
        let homeColor = EventHelper.getScoreColor(for: event, isHomeTeam: true)
        let awayColor = EventHelper.getScoreColor(for: event, isHomeTeam: false)
            
        matchView.setHomeScoreLabel(homeScore)
        matchView.setHomeScoreLabelColor(homeColor)
            
        matchView.setAwayScoreLabel(awayScore)
        matchView.setAwayScoreLabelColor(awayColor)
    }
}


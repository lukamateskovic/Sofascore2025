import UIKit
import SnapKit
import SofaAcademic

class MatchViewCell: UITableViewCell {

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

    private func formatStartTime(for event: Event) -> String {
        let timestamp = event.startTimestamp
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    private func getTimeDescription(for event: Event) -> String {
        switch event.status {
            case .finished:
                return "FT"
            case .inProgress:
                let currentDateTime = Date()
                let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
                let minutesPassed = Int((currentDateTime.timeIntervalSince(date)) / 60)
                return "\(minutesPassed)'"
            default:
                return "-"
        }
    }

    private func getTimeColor(for event: Event) -> UIColor {
        switch event.status {
            case .inProgress:
                return .systemRed
            default:
                return .gray
        }
    }

    private func getScoreColor(for event: Event, isHomeTeam: Bool) -> UIColor {
        switch event.status {
            case .finished:
                if isHomeTeam {
                    if event.homeScore ?? 0 > event.awayScore ?? 0 {
                        return .black
                    } else {
                        return .gray
                    }
                } else {
                    if event.awayScore ?? 0 > event.homeScore ?? 0 {
                        return .black
                    } else {
                        return .gray
                    }
                }
            case .inProgress:
                return .systemRed
            default:
                return .black
        }
    }

    private func getTeamColor(for event: Event, isHomeTeam: Bool) -> UIColor {
        switch event.status {
            case .finished:
                if isHomeTeam {
                    if event.homeScore ?? 0 > event.awayScore ?? 0 {
                        return .black
                    } else {
                        return .gray
                    }
                } else {
                    if event.awayScore ?? 0 > event.homeScore ?? 0 {
                        return .black
                    } else {
                        return .gray
                    }
                }
            default:
                return .black
        }
    }
}

extension MatchViewCell{
    func configureCell(event: Event) {
        matchView.setStartTimeLabel(formatStartTime(for: event))
        matchView.setTimeLabel(getTimeDescription(for: event))
        matchView.setTimeLabelColor(getTimeColor(for: event))
        
        matchView.setHomeTeamImage(UIImage(named: event.homeTeam.name.lowercased()))
        matchView.setHomeTeamLabel(event.homeTeam.name)
        matchView.setHomeTeamLabelColor(getTeamColor(for: event, isHomeTeam: true))
        
        matchView.setAwayTeamImage(UIImage(named: event.awayTeam.name.lowercased()))
        matchView.setAwayTeamLabel(event.awayTeam.name)
        matchView.setAwayTeamLabelColor(getTeamColor(for: event, isHomeTeam: false))
        
        matchView.setHomeScoreLabel(event.homeScore != nil ? String(event.homeScore!) : "")
        matchView.setHomeScoreLabelColor(event.homeScore != nil ? getScoreColor(for: event, isHomeTeam: true) : .black)

        matchView.setAwayScoreLabel(event.awayScore != nil ? String(event.awayScore!) : "")
        matchView.setAwayScoreLabelColor(event.awayScore != nil ? getScoreColor(for: event, isHomeTeam: false) : .black)
    }
}


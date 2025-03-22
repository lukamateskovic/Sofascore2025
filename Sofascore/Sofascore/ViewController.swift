import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {

    private var leagueView = LeagueView()
    private var matchViews: [MatchView] = []
    private let dataSource = Homework2DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(leagueView)
        makeMatchViews()
        setUpConstraints()
        updateLeagueView()
        updateMatchView()
    }
    
    private func makeMatchViews() {
        let events = dataSource.laLigaEvents()
        for _ in events {
            let matchView = MatchView()
            matchViews.append(matchView)
            view.addSubview(matchView)
        }
    }

    private func setUpConstraints() {
        leagueView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(0)
        }
        
        var previousView: UIView = leagueView
        
        for matchView in matchViews {
            matchView.snp.makeConstraints {
                $0.top.equalTo(previousView.snp.bottom).offset(0)
                $0.leading.trailing.equalToSuperview().inset(0)
                $0.height.equalTo(56)
            }
            previousView = matchView
        }
    }
    
    private func updateLeagueView() {
        let league = dataSource.laLigaLeague()
        leagueView.setleagueLogoImage(UIImage(named: "LaLiga1"))
        leagueView.setCountryLabel(league.country?.name ?? "")
        leagueView.setPointerImage()
        leagueView.setLeagueLabel(league.name)
    }
    
    private func updateMatchView() {
        for (index, matchView) in matchViews.enumerated() {
            let event = dataSource.laLigaEvents()[index]
            let homeTeamImage = UIImage(named: event.homeTeam.name.lowercased())
            let awayTeamImage = UIImage(named: event.awayTeam.name.lowercased())
            
            matchView.setStartTimeLabel(formatStartTime(for: event))
            matchView.setTimeLabel(getTimeDescription(for: event))
            matchView.setTimeLabelColor(getTimeColor(for: event))
            
            matchView.setHomeTeamImage(homeTeamImage)
            matchView.setHomeTeamLabel(event.homeTeam.name)
            matchView.setHomeTeamLabelColor(getTeamColor(for: event, isHomeTeam: true))
            
            matchView.setAwayTeamImage(awayTeamImage)
            matchView.setAwayTeamLabel(event.awayTeam.name)
            matchView.setAwayTeamLabelColor(getTeamColor(for: event, isHomeTeam: false))
            
            matchView.setHomeScoreLabel(event.homeScore != nil ? String(event.homeScore!) : "")
            matchView.setHomeScoreLabelColor(event.homeScore != nil ? getScoreColor(for: event, isHomeTeam: true) : .black)

            matchView.setAwayScoreLabel(event.awayScore != nil ? String(event.awayScore!) : "")
            matchView.setAwayScoreLabelColor(event.awayScore != nil ? getScoreColor(for: event, isHomeTeam: false) : .black)
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

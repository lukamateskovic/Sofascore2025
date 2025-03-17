import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {

    private var leagueView = LeagueView()
    private var matchViews: [MatchView] = []
    private let dataSource = Homework2DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Pozadinska boja
        view.addSubview(leagueView)
        
        let events = dataSource.laLigaEvents()
        for _ in events {
            let matchView = MatchView()
            matchViews.append(matchView)
            view.addSubview(matchView)
        }
        createView()
        leagueData()
        matchData()
    }

    private func createView() {
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
    
    private func leagueData() {
        let league = dataSource.laLigaLeague()
        leagueView.logoImageView.image = UIImage(named: "LaLiga1")
        if let country = league.country {
            leagueView.countryLabel.text = country.name
        } else {
            leagueView.countryLabel.text = ""
        }
        leagueView.pointer.image = UIImage(named: "pointer")
        leagueView.leagueLabel.text = league.name
    }
    
    private func matchData() {
        for (index, matchView) in matchViews.enumerated() {
            let event = dataSource.laLigaEvents()[index]
            let homeTeamImage = UIImage(named: event.homeTeam.name.lowercased())
            matchView.homeTeamImageView.image = homeTeamImage
            let awayTeamImage = UIImage(named: event.awayTeam.name.lowercased())
            matchView.awayTeamImageView.image = awayTeamImage
            
            
            let timestamp = event.startTimestamp
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: date)
            
            matchView.startTimeLabel.text = timeString
            
            matchView.homeTeamLabel.text = event.homeTeam.name
            matchView.awayTeamLabel.text = event.awayTeam.name
            
            if let homeScore = event.homeScore {
                matchView.scoreLabelHome.text = String(homeScore)
            } else {
                matchView.scoreLabelHome.text = ""
            }
            if let awayScore = event.awayScore {
                matchView.scoreLabelAway.text = String(awayScore)
            } else {
                matchView.scoreLabelAway.text = ""
            }
                    
            if event.status == .finished {
                matchView.timeLabel.text = "FT"
                if event.homeScore ?? 0 > event.awayScore ?? 0 {
                    matchView.awayTeamLabel.textColor = .gray
                    matchView.scoreLabelAway.textColor = .gray
                }
                if event.awayScore ?? 0 > event.homeScore ?? 0 {
                    matchView.homeTeamLabel.textColor = .gray
                    matchView.scoreLabelHome.textColor = .gray
                }
            }
            
            else if event.status == .inProgress {
                let currentDateTime = Date()
                let minutesPassed = Int((currentDateTime.timeIntervalSince(date)) / 60)
                matchView.timeLabel.text = "\(minutesPassed)'"
                matchView.timeLabel.textColor = .systemRed
                matchView.scoreLabelHome.textColor = .systemRed
                matchView.scoreLabelAway.textColor = .systemRed
            }
            
            else{
                matchView.timeLabel.text = "-"
            }
        }
    }
}

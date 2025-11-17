import UIKit
import SnapKit
import SofaAcademic

final class TeamDetailsView: BaseView {
    private let teamInfo: UILabel = .init()
    private let managerView = PlayerView()
    private let separator1: UIView = .init()
    private let playersStatsView =  PlayersStatsView()
    private let separator2: UIView = .init()
    private let tournamentsView = TournamentsView()
    private let separator3: UIView = .init()
    private let venueView = VenueView()
    
    override func addViews() {
        addSubview(teamInfo)
        addSubview(managerView)
        addSubview(separator1)
        addSubview(playersStatsView)
        addSubview(separator2)
        addSubview(tournamentsView)
        addSubview(separator3)
        addSubview(venueView)
    }
    
    override func styleViews() {
        backgroundColor = .white
        
        teamInfo.text = "Team Info"
        teamInfo.font = .roboto(size: 18, weight: .bold)
        teamInfo.textAlignment = .center
        
        [separator1, separator2, separator3].forEach {
            $0.backgroundColor = .lightGray
        }
    }
    
    override func setupConstraints() {
        teamInfo.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        managerView.snp.makeConstraints {
            $0.top.equalTo(teamInfo.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }
        separator1.snp.makeConstraints {
            $0.top.equalTo(managerView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        playersStatsView.snp.makeConstraints {
            $0.top.equalTo(separator1.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        separator2.snp.makeConstraints {
            $0.top.equalTo(playersStatsView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        tournamentsView.snp.makeConstraints {
            $0.top.equalTo(separator2.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        separator3.snp.makeConstraints {
            $0.top.equalTo(tournamentsView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        venueView.snp.makeConstraints {
            $0.top.equalTo(separator3.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    func configure(manager: TeamManager?, players: [TeamPlayer], clubCountry: String, tournaments: [TeamTournament], venue: TeamVenue?) {
        if let manager = manager {
            managerView.configure(
                name: manager.name,
                country: manager.country.name,
                imageUrl: manager.imageUrl
            )
        }
        
        let totalPlayers = players.count
        let foreignPlayers = players.filter { $0.country.name != clubCountry }.count
        playersStatsView.configure(total: totalPlayers, foreign: foreignPlayers)
        
        tournamentsView.configure(tournaments: tournaments)
        
        venueView.configure(venue: venue)
    }
}


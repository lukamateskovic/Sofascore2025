import UIKit
import SnapKit
import SofaAcademic

class FootballViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let dataSource = Homework3DataSource()
    private var laLigaEvents: [Event] = []
    private var premierLeagueEvents: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        sortEventsByLeague()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeagueViewCell.self, forCellReuseIdentifier: "LeagueCell")
        tableView.register(MatchViewCell.self, forCellReuseIdentifier: "MatchCell")
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func sortEventsByLeague() {
        let allEvents = dataSource.events()
        laLigaEvents = allEvents.filter { $0.league?.name == "La Liga" }
        premierLeagueEvents = allEvents.filter { $0.league?.name == "Premier League" }
    }
}

extension FootballViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return section == 0 ? laLigaEvents.count : premierLeagueEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchViewCell
        let event = indexPath.section == 0 ? laLigaEvents[indexPath.row] : premierLeagueEvents[indexPath.row]
        cell.configureCell(event: event)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

extension FootballViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = LeagueView()
        headerView.backgroundColor = .white

        let events = dataSource.events()
        let league: League?

        if section == 0 {
            league = events.first(where: { $0.league?.name == "La Liga" })?.league
        } else {
            league = events.first(where: { $0.league?.name == "Premier League" })?.league
        }

        guard let league = league else { return nil }

        let leagueLogo = UIImage(named: league.name.lowercased())
        headerView.setleagueLogoImage(leagueLogo)
        headerView.setCountryLabel(league.country?.name ?? "")
        headerView.setLeagueLabel(league.name)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}

    

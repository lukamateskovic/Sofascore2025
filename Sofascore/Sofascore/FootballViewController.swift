import UIKit
import SnapKit
import SofaAcademic

struct LeagueSection {
    let league: League
    let events: [Event]
}

class FootballViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let dataSource = Homework3DataSource()
    private var sortedLeagues: [LeagueSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraints()
        filterEventsByLeague()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeagueViewCell.self, forCellReuseIdentifier: LeagueViewCell.reuseIdentifier)
        tableView.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func filterEventsByLeague() {
        let allEvents = dataSource.events()

        let groupedEvents = Dictionary(grouping: allEvents) { event in
            event.league?.id ?? 0
        }

        sortedLeagues = groupedEvents.compactMap { (leagueID, events) in
            guard let league = events.first(where: { $0.league != nil })?.league else {
                return nil
            }
            return LeagueSection(league: league, events: events)
        }
        .sorted { $0.league.id < $1.league.id }
    }

}

extension FootballViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedLeagues.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedLeagues[section].events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchViewCell.reuseIdentifier, for: indexPath) as! MatchViewCell
        let event = sortedLeagues[indexPath.section].events[indexPath.row]
        guard let configurableCell = cell as? CellConfigurable else {
            fatalError("Ćelija tipa \(type(of: cell)) ne podržava CellConfigurable")
        }
        configurableCell.configure(with: event)
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
        let league = sortedLeagues[section].league
        
        headerView.setLeagueLabel(league.name)
        headerView.setCountryLabel(league.country?.name ?? "Nepoznata država")
        
        let imageName = league.name.lowercased()
        headerView.setleagueLogoImage(UIImage(named: imageName))
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
}

    

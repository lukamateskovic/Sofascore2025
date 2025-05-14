import UIKit
import SnapKit

struct LeagueSection {
   let league: League
   let events: [Event]
}

class FootballViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var sortedLeagues: [LeagueSection] = []
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    let matchDetailsVC = EventDetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { $0.center.equalToSuperview() }
        loadingIndicator.startAnimating()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeagueViewCell.self, forCellReuseIdentifier: LeagueViewCell.reuseIdentifier)
        tableView.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.reuseIdentifier)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.isHidden = true
    }
    
    private func loadData() {
        APIClient.getGames(sport: .football) { [weak self] events in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                
                CoreDataService.shared.saveEvents(events)
                    
                if events.isEmpty {
                    self?.showError("Nema dostupnih podataka")
                    return
                }
                        
                self?.processEvents(events)
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
        }
    }
    
    private func processEvents(_ events: [Event]) {
        let groupedEvents = Dictionary(grouping: events) { $0.league.id }
        
        sortedLeagues = groupedEvents.compactMap { key, events in
            guard let league = events.first?.league else { return nil }
            return LeagueSection(league: league, events: events.sorted { $0.startTimestamp < $1.startTimestamp })
        }
        .sorted { $0.league.id < $1.league.id }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Greška", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        loadingIndicator.stopAnimating()
    }
}

extension FootballViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int { sortedLeagues.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedLeagues[section].events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchViewCell.reuseIdentifier,
            for: indexPath
        ) as? MatchViewCell else {
            fatalError("Nepoznata ćelija")
        }
                
        guard let leagueSection = sortedLeagues[safe: indexPath.section],
            let event = leagueSection.events[safe: indexPath.row] else {
            return cell
        }
                
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = LeagueView()
        let league = sortedLeagues[section].league
        header.setLeagueLabel(league.name)
        header.setCountryLabel(league.country.name)
        header.backgroundColor = .white
        
        if let logoUrl = league.logoUrl {
            URLSession.shared.dataTask(with: logoUrl) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        header.setleagueLogoImage(image)
                    }
                }
            }.resume()
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    
        guard let leagueSection = sortedLeagues[safe: indexPath.section],
              let event = leagueSection.events[safe: indexPath.row] else {
            return
        }
    
        matchDetailsVC.configure(with: event)

        navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
}

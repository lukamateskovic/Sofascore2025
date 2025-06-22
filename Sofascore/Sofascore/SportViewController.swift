import UIKit
import SnapKit

struct LeagueSection {
   let league: League
   let events: [Event]
}

class SportViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(sport: SportSlug) {
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }
    
    private let sport: SportSlug
    private let tableView: UITableView = .init(frame: .zero, style: .plain)
    private var sortedLeagues: [LeagueSection] = []
    private let loadingIndicator: UIActivityIndicatorView = .init(style: .large)
    
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
        APIClient.fetchSecureEvents(sport: sport) { [weak self] result in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                switch result {
                case .success(let events):
                    CoreDataService.shared.saveEvents(events)
                    if events.isEmpty {
                        self?.showError("Nema dostupnih podataka")
                        return
                    }
                    self?.processEvents(events)
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                case .failure(let error):
                    self?.showError(error.localizedDescription)
                }
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
    
    @objc private func didTapLeagueHeader(_ sender: UITapGestureRecognizer) {
        guard let header = sender.view else { return }
        let section = header.tag
            
        guard let league = sortedLeagues[safe: section]?.league else { return }
        let leagueVC = LeagueViewController(league: league, sport: sport)
        navigationController?.pushViewController(leagueVC, animated: true)
    }
}

extension SportViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        if let logoUrl = URL(string: league.logoUrl) {
            URLSession.shared.dataTask(with: logoUrl) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        header.setleagueLogoImage(image)
                    }
                }
            }.resume()
        }
        
        header.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLeagueHeader(_:)))
        header.addGestureRecognizer(tap)
        header.tag = section
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let leagueSection = sortedLeagues[safe: indexPath.section],
              let event = leagueSection.events[safe: indexPath.row] else {
            return
        }
        let logoUrlString = event.league.logoUrl
        let matchDetailsVC = EventDetailsViewController()
        matchDetailsVC.configure(with: event, sport: sport, logoUrlString: logoUrlString)
        navigationController?.pushViewController(matchDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 56 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 56 }
}

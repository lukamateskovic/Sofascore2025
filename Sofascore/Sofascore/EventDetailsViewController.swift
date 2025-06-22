import UIKit
import SnapKit
import SofaAcademic

class EventDetailsViewController: UIViewController {
    
    private let matchDetailsView = EventDetailsView()
    private var event: Event?
    private var currentSport: SportSlug = .football
    private var incidents: [Incident] = []
    private var basketballScores: [(home: Int, away: Int)] = []
    
    private let incidentsTableView: UITableView = .init(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
        setupTableView()
        setupMatchDetailsView()
    }
    
    private func setupViews() {
        view.addSubview(incidentsTableView)
        
        incidentsTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        incidentsTableView.delegate = self
        incidentsTableView.dataSource = self
        incidentsTableView.register(IncidentCell.self, forCellReuseIdentifier: IncidentCell.reuseIdentifier)
        incidentsTableView.separatorStyle = .none
        incidentsTableView.backgroundColor = .white
        incidentsTableView.layer.cornerRadius = 8
    }
    
    func configure(with event: Event, sport: SportSlug, logoUrlString: String?) {
        self.event = event
        self.currentSport = sport
        
        let league = event.league
        let sportName: String
        switch currentSport {
        case .football: sportName = "Football"
        case .basketball: sportName = "Basketball"
        case .americanFootball: sportName = "American Football"
        }
        let countryName = league.country.name
        let leagueName = league.name
        let roundInfo: String
        if let round = event.round {
            roundInfo = "Round \(round)"
        } else {
            roundInfo = ""
        }

        let titleView = EventTitleView()
        
        titleView.configure(
            sportName: sportName,
            countryName: countryName,
            leagueName: leagueName,
            roundInfo: roundInfo,
            logoUrl: logoUrlString
        )
        navigationItem.titleView = titleView
        
        if isViewLoaded {
            matchDetailsView.configure(with: event)
            loadIncidents()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
        
        if let event = event {
            matchDetailsView.configure(with: event)
            loadIncidents()
        }
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func loadIncidents() {
        guard let eventId = event?.id else { return }
        
        APIClient.fetchIncidents(eventId: eventId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let incidents):
                    print("API odgovor (incidenti):", incidents)
                    self?.incidents = incidents
                    if self?.currentSport == .basketball {
                        self?.calculateBasketballScores()
                    }
                    self?.incidentsTableView.reloadData()
                case .failure(let error):
                    print("Error loading incidents: \(error)")
                }
            }
        }
    }
    
    private func calculateBasketballScores() {
        var homeScore = 0
        var awayScore = 0
        basketballScores = incidents.map { incident in
            if incident.type == .goal, let diff = incident.scoreDiff {
                incident.isHomeTeam == true ? (homeScore += Int(diff)) : (awayScore += Int(diff))
            }
            return (homeScore, awayScore)
        }
    }
    
    private func setupMatchDetailsView() {
        matchDetailsView.onTeamTap = { [weak self] team in
            let teamVC = TeamViewController(team: team)
            self?.navigationController?.pushViewController(teamVC, animated: true)
        }
    }
}

extension EventDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let event = event else { return nil }
        let container = UIView()
        container.backgroundColor = .clear

        matchDetailsView.configure(with: event)
        container.addSubview(matchDetailsView)
        matchDetailsView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(112)
        }

        let spacer = UIView()
        spacer.backgroundColor = .lightGray
        container.addSubview(spacer)
        spacer.snp.makeConstraints {
            $0.top.equalTo(matchDetailsView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16) 
            $0.bottom.equalToSuperview()
        }

        return container
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 112 + 16}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IncidentCell.reuseIdentifier, for: indexPath) as? IncidentCell else {
            fatalError("Unable to dequeue IncidentCell")
        }
        let incident = incidents[incidents.count - 1 - indexPath.row]
        if currentSport == .basketball {
            let currentScore = basketballScores[incidents.count - 1 - indexPath.row]
            cell.configure(with: incident, sport: currentSport,
                basketballScore: currentSport == .basketball ? "\(currentScore.home) - \(currentScore.away)" : nil
            )
        } else {
            cell.configure(with: incident, sport: currentSport)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return currentSport == .basketball ? 40 : 56
    }
}

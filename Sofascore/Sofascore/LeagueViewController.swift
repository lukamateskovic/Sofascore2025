import UIKit
import SnapKit
import SofaAcademic

enum Tab {
    case matches,
         standings
}

class LeagueViewController: UIViewController {
    enum Tab { case matches, standings }
    
    private var currentSport: SportSlug = .football
    private let league: League
    private var currentTab: Tab = .matches
    private let tabBarView = TabBarView()
    private let contentView: UIView = .init()
    private let matchesTableView: UITableView = .init()
    private let standingsTableView: UITableView = .init()
    
    private var matches: [Event] = []
    private var standings: [Standing] = []
    private var groupedMatches: [(round: String, matches: [Event])] = []
    
    private let titleHeaderView = LeagueHeaderView()
    private var previousScrollOffset: CGFloat = 0

    init(league: League, sport: SportSlug) {
        self.currentSport = sport
        self.league = league
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViews()
        setupTableViews()
        loadData()
        if #available(iOS 15.0, *) {
            matchesTableView.sectionHeaderTopPadding = 0
            standingsTableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        titleHeaderView.configure(with: league)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(titleHeaderView)
        titleHeaderView.configure(with: league)
        titleHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        tabBarView.configure(tabs: ["Matches", "Standings"])
        view.addSubview(tabBarView)
        tabBarView.delegate = self
        tabBarView.snp.makeConstraints {
            $0.top.equalTo(titleHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(contentView)
        contentView.backgroundColor = .lightGray
        contentView.snp.makeConstraints {
            $0.top.equalTo(tabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        titleHeaderView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.size.equalTo(24)
        }
    }
    
    private func setupTableViews() {
        contentView.addSubview(matchesTableView)
        contentView.addSubview(standingsTableView)
        
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
        matchesTableView.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.reuseIdentifier)
        matchesTableView.backgroundColor = .lightGray
        matchesTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        standingsTableView.register(StandingCell.self, forCellReuseIdentifier: StandingCell.reuseIdentifier)
        standingsTableView.backgroundColor = .lightGray
        standingsTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        standingsTableView.isHidden = true
    }
    
    private func loadData() {
        loadMatches()
        loadStandings()
    }
    
    private func loadMatches() {
        APIClient.fetchLeagueMatches(leagueId: Int64(league.id)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let matches):
                    print("API odgovor (incidenti):", matches)
                    self?.matches = matches
                    self?.groupMatchesByRound()
                    self?.matchesTableView.reloadData()
                case .failure(let error):
                    print("Error loading matches:", error)
                }
            }
        }
    }
    
    private func loadStandings() {
        APIClient.fetchLeagueStandings(leagueId: Int64(league.id)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let standings):
                    print("API odgovor (incidenti):", standings)
                    self?.standings = standings
                    self?.standingsTableView.reloadData()
                case .failure(let error):
                    print("Error loading standings:", error)
                }
            }
        }
    }
    
    private func groupMatchesByRound() {
        let grouped = Dictionary(grouping: matches) { "Round \($0.round ?? 1)" }
        groupedMatches = grouped.map { (round: $0.key, matches: $0.value) }
            .sorted { $0.round < $1.round }
    }
    
    func navigateToTeam(_ team: Team) {
        let teamVC = TeamViewController(team: team)
        navigationController?.pushViewController(teamVC, animated: true)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension LeagueViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        let scrollDiff = scrollOffset - previousScrollOffset
        let isScrollingDown = scrollDiff > 0 && scrollOffset > 0
        let isScrollingUp = scrollDiff < 0
            
        var newHeight = titleHeaderView.frame.height
           
        if isScrollingDown {
            newHeight = max(44, newHeight - abs(scrollDiff))
        }
        else if isScrollingUp {
            newHeight = min(120, newHeight + abs(scrollDiff))
        }
            
        titleHeaderView.snp.updateConstraints {
            $0.height.equalTo(newHeight)
        }
        
        let shouldCollapse = newHeight <= 60
        titleHeaderView.setCollapsed(shouldCollapse, animated: false)
            
        previousScrollOffset = scrollOffset
    }
}

extension LeagueViewController: TabBarViewDelegate {
    func didSelectTab(index: Int) {
        currentTab = index == 0 ? .matches : .standings
        matchesTableView.isHidden = currentTab != .matches
        standingsTableView.isHidden = currentTab != .standings
    }
}

extension LeagueViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView == matchesTableView ? groupedMatches.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == matchesTableView ? groupedMatches[section].matches.count : standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == matchesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MatchViewCell.reuseIdentifier, for: indexPath) as! MatchViewCell
            cell.configure(with: groupedMatches[indexPath.section].matches[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StandingCell.reuseIdentifier, for: indexPath) as! StandingCell
            cell.configure(with: standings[indexPath.row], sport: currentSport)
            cell.teamTapAction = { [weak self] in
                guard let self = self else { return }
                let team = standings[indexPath.row].team
                self.navigateToTeam(team)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if tableView == standingsTableView {
                let header = StandingsHeaderView()
                switch currentSport {
                case .football:
                    header.configure(titles: ["#", "Team", "P", "W", "D", "L", "Goals", "PTS"], sport: currentSport)
                case .basketball:
                    header.configure(titles: ["#", "Team", "P", "W", "L", "DIFF", "Str", "GB", "PCT"], sport: currentSport)
                case .americanFootball:
                    header.configure(titles: ["#", "Team", "P", "W", "D", "L", "PCT"], sport: currentSport)
                }
                header.backgroundColor = .white
                return header
            }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        tableView == matchesTableView ? groupedMatches[section].round : nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView == matchesTableView ? 56 : 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == standingsTableView {
            return 56
        }
        return tableView == matchesTableView ? 48 : 0
    }
}

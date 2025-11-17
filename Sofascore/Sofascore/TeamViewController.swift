import UIKit
import SnapKit
import SofaAcademic

class TeamViewController: UIViewController {
    enum Tab { case details, players }
    
    private let team: Team
    private var currentTab: Tab = .details
    private let tabBarView = TabBarView()
    private let contentView: UIView = .init()
    private let detailsScrollView: UIScrollView = .init()
    private let detailsContentView = TeamDetailsView()
    private let playersTableView: UITableView = .init()
    
    private var teamDetails: TeamInfoResponse?
    private var players: [TeamPlayer] = []
    private var tournaments: [TeamTournament] = []
    
    private let headerView = TeamHeaderView()
    private var previousScrollOffset: CGFloat = 0

    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViews()
        setupTableView()
        loadData()
        if #available(iOS 15.0, *) {
            playersTableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func setupNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(headerView)
        updateHeader()
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        tabBarView.configure(tabs: ["Details", "Players"])
        tabBarView.delegate = self
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        view.addSubview(contentView)
        contentView.backgroundColor = .lightGray
        contentView.snp.makeConstraints {
            $0.top.equalTo(tabBarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.addSubview(detailsScrollView)
        detailsScrollView.addSubview(detailsContentView)
        detailsScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        detailsContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        contentView.addSubview(playersTableView)
        playersTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        playersTableView.isHidden = true
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        headerView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.size.equalTo(24)
        }
    }
    
    private func setupTableView() {
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playersTableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.reuseIdentifier)
        playersTableView.backgroundColor = .lightGray
        playersTableView.rowHeight = 64
    }
    
    private func loadData() {
        loadTeamDetails()
        loadPlayers()
        loadTournaments()
    }
    
    private func loadTeamDetails() {
        APIClient.fetchTeamDetails(teamId: Int64(team.id)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.teamDetails = response
                    self?.updateHeader()
                    self?.updateDetailsView()
                    self?.playersTableView.reloadData()
                case .failure(let error):
                    print("Error loading team details:", error.localizedDescription)
                }
            }
        }
    }
    
    private func loadPlayers() {
        APIClient.fetchTeamPlayers(teamId: Int64(team.id)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let players):
                    self?.players = players
                    self?.playersTableView.reloadData()
                case .failure(let error):
                    print("Error loading players:", error.localizedDescription)
                }
            }
        }
    }
    
    private func loadTournaments() {
        APIClient.fetchTeamTournaments(teamId: Int64(team.id)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let tournaments):
                    self?.tournaments = tournaments
                    self?.updateDetailsView()
                case .failure(let error):
                    print("Error loading tournaments:", error.localizedDescription)
                }
            }
        }
    }
    
    private func updateHeader() {
        guard let teamDetails = teamDetails else { return }
        headerView.configure(with: teamDetails.team)
    }
    
    private func updateDetailsView() {
        guard let teamDetails = teamDetails else { return }
        
        detailsContentView.configure(
            manager: teamDetails.manager,
            players: players,
            clubCountry: teamDetails.team.country.name,
            tournaments: tournaments,
            venue: teamDetails.venue
        )
    }
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension TeamViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        let scrollDiff = scrollOffset - previousScrollOffset
        let isScrollingDown = scrollDiff > 0 && scrollOffset > 0
        let isScrollingUp = scrollDiff < 0
            
        var newHeight = headerView.frame.height
           
        if isScrollingDown {
            newHeight = max(44, newHeight - abs(scrollDiff))
        }
        else if isScrollingUp {
            newHeight = min(120, newHeight + abs(scrollDiff))
        }
            
        headerView.snp.updateConstraints {
            $0.height.equalTo(newHeight)
        }
        
        let shouldCollapse = newHeight <= 60
        headerView.setCollapsed(shouldCollapse, animated: false)
            
        previousScrollOffset = scrollOffset
    }
}

extension TeamViewController: TabBarViewDelegate {
    func didSelectTab(index: Int) {
        currentTab = index == 0 ? .details : .players
        detailsScrollView.isHidden = currentTab != .details
        playersTableView.isHidden = currentTab != .players
    }
}

extension TeamViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teamDetails?.manager != nil ? 1 : 0
        } else {
            return players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.reuseIdentifier, for: indexPath) as! PlayerCell
        
        if indexPath.section == 0, let manager = teamDetails?.manager {
            cell.configureAsManager(with: manager)
        } else {
            cell.configure(with: players[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        let titleLabel = UILabel()
        titleLabel.font = .roboto(size: 16, weight: .bold)
        titleLabel.textColor = .darkGray
        titleLabel.text = section == 0 ? "  Coach" : "  Players"
        
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

import UIKit
import SnapKit
import SofaAcademic

final class StandingCell: UITableViewCell {
    static let reuseIdentifier = "StandingCell"
    private var currentView: BaseView?
    var teamTapAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with standing: Standing, sport: SportSlug) {
        currentView?.removeFromSuperview()
        
        switch sport {
        case .football:
            let view = StandingsFootballView()
            view.configure(
                position: "\(standing.position)",
                team: standing.team.name,
                played: "\(standing.matches)",
                won: "\(standing.wins)",
                draw: "\(standing.draws)",
                lost: "\(standing.losses)",
                goals: standing.goals,
                points: standing.displayPoints,
                highlightPosition: Int(standing.position)
            )
            view.onTeamTap = { [weak self] in
                guard let self = self else { return }
                self.teamTapAction?()
            }
            currentView = view
            
        case .basketball:
            let view = StandingsBasketballView()
            view.configure(
                position: "\(standing.position)",
                team: standing.team.name,
                played: "\(standing.matches)",
                won: "\(standing.wins)",
                lost: "\(standing.losses)",
                diff: standing.goalDifference,
                str: "4",
                gb: "16.0", 
                pct: standing.percentage != nil ? String(format: "%.3f", standing.percentage!) : "0.000",
                highlightPosition: Int(standing.position)
            )
            view.onTeamTap = { [weak self] in
                guard let self = self else { return }
                self.teamTapAction?()
            }
            currentView = view
            
        case .americanFootball:
            let view = StandingsAmericanFootballView()
            view.configure(
                position: "\(standing.position)",
                team: standing.team.name,
                played: "\(standing.matches)",
                won: "\(standing.wins)",
                draw: "\(standing.draws)",
                lost: "\(standing.losses)",
                pct: standing.percentage != nil ? String(format: "%.3f", standing.percentage!) : "0.000",
                highlightPosition: Int(standing.position)
            )
            view.onTeamTap = { [weak self] in
                guard let self = self else { return }
                self.teamTapAction?()
            }
            currentView = view
        }
        
        guard let currentView = currentView else { return }
        contentView.addSubview(currentView)
        currentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

import UIKit
import SnapKit
import SofaAcademic

final class IncidentCell: UITableViewCell {
    static let reuseIdentifier = "IncidentCell"
    
    private var currentView: BaseView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    func configure(with incident: Incident, sport: SportSlug, basketballScore: String? = nil) {
        currentView?.removeFromSuperview()
        
        let currentView: BaseView
        switch sport {
        case .football:
            let view = FootballIncidentView()
            let minute = incident.extraMinute != nil ? "\(incident.minute)+\(incident.extraMinute!)" : "\(incident.minute)'"
            view.configure(
                minute: minute,
                player: incident.player ?? "",
                description: incident.description ?? "",
                score: incident.score ?? "",
                isHomeTeam: incident.isHomeTeam ?? false,
                icon: iconForFootballIncident(incident.type),
                incidentType: incident.type
            )
            currentView = view
            
        case .basketball:
            let view = BasketballIncidentView()
            let icon = iconForBasketballIncident(incident.scoreDiff)
            view.configure(
                icon: icon,
                action: incident.description ?? incident.type.rawValue,
                minute: "\(incident.minute)'",
                score: basketballScore ?? "0 - 0",
                isHomeTeam: incident.isHomeTeam ?? false,
                incidentType: incident.type
            )
            currentView = view
            
        case .americanFootball:
            let view = AmericanFootballIncidentView()
            let minute = incident.extraMinute != nil ? "\(incident.minute)+\(incident.extraMinute!)" : "\(incident.minute)'"
            view.configure(
                minute: minute,
                player: incident.player ?? "",
                score: incident.score ?? "",
                description: incident.description ?? "",
                isHomeTeam: incident.isHomeTeam ?? false,
                icon: UIImage(named: "lopta"),
                incidentType: incident.type
            )
            currentView = view
        }
        
        contentView.addSubview(currentView)
        currentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func iconForFootballIncident(_ type: IncidentType) -> UIImage? {
        switch type {
        case .goal:
            return UIImage(named: "lopta")
        case .redCard:
            return UIImage(named: "karton")?.withTintColor(UIColor.red)
        case .yellowCard:
            return UIImage(named: "karton")
        default:
            return UIImage(systemName: "exclamationmark.triangle")
        }
    }
    
    private func iconForBasketballIncident(_ scoreDiff: Int32?) -> UIImage? {
        switch abs(scoreDiff ?? 0) {
        case 2:
            return UIImage(named: "2")
        case 3:
            return UIImage(named: "3")
        default:
            return UIImage(named: "lopta")
        }
    }

}

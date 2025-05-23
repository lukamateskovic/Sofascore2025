import UIKit
import SnapKit
import SofaAcademic

final class SettingsView: BaseView {

    let dismissButton = UIButton(type: .system)
    let nameLabel = UILabel()
    let logoutButton = UIButton(type: .system)
    let eventCountLabel = UILabel()
    let leagueCountLabel = UILabel()
    
    private let countsStack = UIStackView()
    private let mainStack = UIStackView()
    
    override func addViews() {
        countsStack.addArrangedSubview(eventCountLabel)
        countsStack.addArrangedSubview(leagueCountLabel)
        
        mainStack.addArrangedSubview(dismissButton)
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(logoutButton)
        mainStack.addArrangedSubview(countsStack)
        
        addSubview(mainStack)
    }
    
    override func styleViews() {
        backgroundColor = .white

        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
 
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.textAlignment = .center

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        logoutButton.setTitleColor(.systemRed, for: .normal)

        eventCountLabel.textAlignment = .center
        leagueCountLabel.textAlignment = .center

        countsStack.axis = .vertical
        countsStack.spacing = 8
        countsStack.alignment = .center
        
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.alignment = .center
    }
    
    override func setupConstraints() {
        mainStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualToSuperview().offset(32)
            $0.trailing.lessThanOrEqualToSuperview().offset(-32)
        }
        dismissButton.snp.makeConstraints { $0.width.equalToSuperview() }
        logoutButton.snp.makeConstraints { $0.width.equalToSuperview() }
        nameLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(160) }
        eventCountLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(120) }
        leagueCountLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(120) }
    }
}

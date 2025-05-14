import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Dismiss", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.addTarget(nil, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(nil, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()

    private let eventCountLabel = UILabel()
    private let leagueCountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateCounts()
        title = "Settings"
    }

    private func setupView() {
        view.backgroundColor = .white

        nameLabel.text = AuthService.shared.currentUser?.name ?? "Unknown user"

        eventCountLabel.textAlignment = .center
        leagueCountLabel.textAlignment = .center

        let countsStack = UIStackView(arrangedSubviews: [eventCountLabel, leagueCountLabel])
        countsStack.axis = .vertical
        countsStack.spacing = 8
        countsStack.alignment = .center

        let mainStack = UIStackView(arrangedSubviews: [
            dismissButton,
            nameLabel,
            logoutButton,
            countsStack
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.alignment = .center

        view.addSubview(mainStack)
        mainStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(view).offset(32)
            $0.trailing.lessThanOrEqualTo(view).offset(-32)
        }

        dismissButton.snp.makeConstraints { $0.width.equalTo(160) }
        logoutButton.snp.makeConstraints { $0.width.equalTo(160) }
        nameLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(160) }
        eventCountLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(120) }
        leagueCountLabel.snp.makeConstraints { $0.width.greaterThanOrEqualTo(120) }
    }

    @objc private func dismissTapped() {
        dismiss(animated: true)
    }

    @objc private func logoutTapped() {
        AuthService.shared.logout()
        dismiss(animated: true)
    }

    private func updateCounts() {
        eventCountLabel.text = "Broj eventa: \(CoreDataService.shared.getEventCount())"
        leagueCountLabel.text = "Broj liga: \(CoreDataService.shared.getLeagueCount())"
    }
}



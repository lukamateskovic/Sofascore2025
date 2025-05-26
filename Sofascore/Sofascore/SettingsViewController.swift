import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    private let settingsView = SettingsView()
    
    override func loadView() {
        self.view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setupActions()
        updateContent()
    }
    
    private func setupActions() {
        settingsView.dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        settingsView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
    
    @objc private func logoutTapped() {
        AuthService.shared.logout()
        dismiss(animated: true)
    }
    
    private func updateContent() {
        settingsView.nameLabel.text = AuthService.shared.currentUser?.name ?? "Unknown user"
        settingsView.eventCountLabel.text = "Broj eventa: \(CoreDataService.shared.getEventCount())"
        settingsView.leagueCountLabel.text = "Broj liga: \(CoreDataService.shared.getLeagueCount())"
    }
}

import UIKit
import SnapKit

class AppCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        setupObservers()
        checkAuthState()
    }
    
    private func checkAuthState() {
        if AuthService.shared.currentUser != nil {
            showMainApp()
        } else {
            showLogin()
        }
    }
    
    private func showMainApp() {
        let eventsVC = NavigationViewController()
        window.rootViewController = UINavigationController(rootViewController: eventsVC)
    }
    
    private func showLogin() {
        window.rootViewController = LoginViewController()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            forName: .authStateChanged,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.checkAuthState()
        }
    }
}


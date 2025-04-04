import UIKit
import SofaAcademic
import SnapKit

class NavigationViewController: UIViewController {
    
    private var stackView: UIStackView = .init()
    private var containerView: UIView = .init()
    private var indicator: UIView = .init()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createViews()
        setupConstraints()
        
        showInitialViewController()
    }
    
    private func createViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
            
        let footballButton = makeButton(
                title: "Football",
                icon: UIImage(named: "Football"),
                indicator: indicator,
                moveIndicatorAction: { [weak self] button in
                    self?.moveIndicator(to: button)
                },
                action: { [weak self] in
                    self?.showViewController(FootballViewController())
                }
            )
            
        let basketballButton = makeButton(
                title: "Basketball",
                icon: UIImage(named: "basketball"),
                indicator: indicator,
                moveIndicatorAction: { [weak self] button in
                    self?.moveIndicator(to: button)
                },
                action: { [weak self] in
                    self?.showViewController(BasketballViewController())
                }
            )
            
        let americanFootballButton = makeButton(
                title: "Am. Football",
                icon: UIImage(named: "american_Football"),
                indicator: indicator,
                moveIndicatorAction: { [weak self] button in
                    self?.moveIndicator(to: button)
                },
                action: { [weak self] in
                    self?.showViewController(AmericanFootballViewController())
                }
            )
            
        stackView.addArrangedSubview(footballButton)
        stackView.addArrangedSubview(basketballButton)
        stackView.addArrangedSubview(americanFootballButton)
        
        containerView.backgroundColor = .lightGray
        view.addSubview(containerView)
        
        indicator.backgroundColor = .white
        indicator.layer.cornerRadius = 2
        footballButton.addSubview(indicator)
    }
    
    private func showInitialViewController() {
        let initialVC = FootballViewController() 
        showViewController(initialVC)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.width.equalTo(104)
            $0.height.equalTo(4)
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    private func makeButton(title: String, icon: UIImage?, indicator: UIView, moveIndicatorAction: @escaping (Button) -> Void, action: @escaping () -> Void) -> Button {
        let button = Button()
        button.setSports(title)
        button.setIcon(icon)

        button.onTap = { [weak button] in
            guard let button = button else { return }
            moveIndicatorAction(button)
            action()
        }

        button.addTapGestureRecognizer()
        
        return button
    }
    
    private func showViewController(_ viewController: UIViewController) {
        containerView.subviews.forEach { $0.removeFromSuperview() }

        addChild(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        viewController.didMove(toParent: self)
    }
    
    func moveIndicator(to button: Button) {

        indicator.removeFromSuperview()

        button.addSubview(indicator)

        indicator.snp.remakeConstraints { make in
            make.width.equalTo(104)
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

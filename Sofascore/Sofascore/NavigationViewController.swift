import UIKit
import SofaAcademic
import SnapKit

class NavigationViewController: UIViewController {
    
    private var stackView: UIStackView!
    private var containerView: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createViews()
        setupConstraints()
    }
    
    private func createViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
            
        let footballButton = makeButton(title: "Football", icon: UIImage(named: "Football"))
        let basketballButton = makeButton(title: "Basketball", icon: UIImage(named: "basketball"))
        let americanFootballButton = makeButton(title: "Am. Football", icon: UIImage(named: "american_Football"))
            
        stackView.addArrangedSubview(footballButton)
        stackView.addArrangedSubview(basketballButton)
        stackView.addArrangedSubview(americanFootballButton)
        
        containerView = UIView()
        containerView.backgroundColor = .lightGray
        view.addSubview(containerView)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func makeButton(title: String, icon: UIImage?) -> Button {
        let button = Button()
        button.setSports(title)
        button.setIcon(icon)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        button.addGestureRecognizer(tapGestureRecognizer)
        button.tag = title.hash

        return button
    }

    @objc private func buttonTapped(_ sender: UITapGestureRecognizer) {

        guard let button = sender.view as? Button else { return }
        
        containerView.subviews.forEach { $0.removeFromSuperview() }

        var viewController: UIViewController?

        switch button.tag {
        case "Football".hash:
            viewController = FootballViewController()
        case "Basketball".hash:
            viewController = BasketballViewController()
        case "Am. Football".hash:
            viewController = AmericanFootballViewController()
        default:
            return
        }
        
        if let viewController = viewController {
            addChild(viewController)
            containerView.addSubview(viewController.view)
            viewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
            viewController.didMove(toParent: self)
        }
    }
    
}

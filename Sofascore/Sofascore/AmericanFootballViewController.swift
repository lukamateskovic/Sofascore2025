import UIKit

class AmericanFootballViewController: UIViewController {
    
    private var americanFootballView: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        styleViews()
        setupConstraints()
    }
    
    private func createViews() {
        view.addSubview(americanFootballView)
    }
    
    private func styleViews() {
        americanFootballView.text = "Nema trenutnih utakmica"
        americanFootballView.textAlignment = .center
        americanFootballView.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    private func setupConstraints() {
        americanFootballView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
    }
}

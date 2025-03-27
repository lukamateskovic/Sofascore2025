import UIKit

class AmericanFootballViewController: UIViewController {
    
    private var americanFootballView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createViews()
        setupConstraints()
    }
    
    private func createViews() {
        americanFootballView = UILabel()
        americanFootballView.text = "Nema trenutnih utakmica"
        americanFootballView.textAlignment = .center
        americanFootballView.font = .systemFont(ofSize: 16, weight: .bold)
        view.addSubview(americanFootballView)
    }
    
    private func setupConstraints() {
        americanFootballView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

import UIKit
import SnapKit
import SofaAcademic

class ViewController: UIViewController {

    private var leagueView = UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // Pozadinska boja
        view.addSubview(leagueView)
        createView()
    }

    private func createView() {
        leagueView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview().inset(0)
        }
        
        // Postavi neki sadržaj za testiranje
        leagueView.logoImageView.image = UIImage(systemName: "circle") // Zamijeni sa željenom slikom
        leagueView.countryLabel.text = "Country"
        leagueView.pointer.image = UIImage(systemName: "arrow.right") // Zamijeni sa željenom slikom
        leagueView.leagueLabel.text = "League Name"
    }
}

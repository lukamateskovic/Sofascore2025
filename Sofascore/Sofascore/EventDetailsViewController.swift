import UIKit
import SnapKit
import SofaAcademic

class EventDetailsViewController: UIViewController {
    
    private let matchDetailsView = EventDetailsView()
    private var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(matchDetailsView)
        
        matchDetailsView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(112)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func configure(with event: Event) {
        self.event = event
        
        let league = event.league
        let sportName = "Football"
        let countryName = league.country.name 
        let leagueName = league.name
        let roundInfo = "Round 15"

        title = "\(sportName), \(countryName), \(leagueName), \(roundInfo)"

        
        if isViewLoaded {
            matchDetailsView.configure(with: event)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
        
        if let event = event {
            matchDetailsView.configure(with: event)
        }
    }
}

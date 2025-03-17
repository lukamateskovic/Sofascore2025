import UIKit
import SofaAcademic
import SnapKit

class LeagueViewController: UIViewController {

    private let matchView1 = MatchView1()
    private let matchView2 = MatchView2()

    private let dataSource = Homework2DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        fetchData()
    }

    private func setupViews() {
        view.backgroundColor = .white // Postavite pozadinu kako ne bi bio bijel ekran
        
        view.addSubview(matchView1)
        view.addSubview(matchView2)
    }

    private func setupConstraints() {
        matchView1.translatesAutoresizingMaskIntoConstraints = false
        matchView2.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            matchView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            matchView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            matchView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            matchView1.heightAnchor.constraint(equalToConstant: 120),

            matchView2.topAnchor.constraint(equalTo: matchView1.bottomAnchor, constant: 16),
            matchView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            matchView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            matchView2.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func fetchData() {
        let events = dataSource.laLigaEvents()

        if events.count > 0 {
            matchView1.configure(with: events[0])
        }
        
        if events.count > 1 {
            matchView2.configure(with: events[1])
        }
    }
}

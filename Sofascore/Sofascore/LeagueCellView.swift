import UIKit
import SnapKit
import SofaAcademic

class LeagueViewCell: UITableViewCell {

    private let leagueView = LeagueView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        contentView.addSubview(leagueView)
        leagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

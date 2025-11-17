import UIKit
import SnapKit
import SofaAcademic

final class PlayerCell: UITableViewCell {
    static let reuseIdentifier = "PlayerCell"
    
    private let playerView = PlayerView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(playerView)
        
        playerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with player: TeamPlayer) {
        playerView.configure(name: player.name, country: player.country.name, imageUrl: player.imageUrl)
    }
    
    func configureAsManager(with manager: TeamManager) {
        playerView.configure(name: manager.name, country: manager.country.name, imageUrl: manager.imageUrl)
    }
}

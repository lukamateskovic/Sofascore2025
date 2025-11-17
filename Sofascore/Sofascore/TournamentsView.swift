import UIKit
import SnapKit
import SofaAcademic

final class TournamentsView: BaseView {
    private let titleLabel: UILabel = .init()
    private let mainStack: UIStackView = .init()
    private let maxTournamentsPerRow = 3
    
    override func addViews() {
        addSubview(titleLabel)
        addSubview(mainStack)
    }
    
    override func styleViews() {
        titleLabel.text = "Tournaments"
        titleLabel.font = .roboto(size: 16, weight: .bold)
        titleLabel.textAlignment = .center
        
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.alignment = .fill
        mainStack.distribution = .equalSpacing
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        mainStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(tournaments: [TeamTournament]) {
        
        mainStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let chunkedTournaments = tournaments.chunked(into: maxTournamentsPerRow)
        
        for rowTournaments in chunkedTournaments {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.distribution = .fillEqually
            rowStack.spacing = 16
            rowStack.alignment = .top
            
            for tournament in rowTournaments {
                
                let tournamentStack = UIStackView()
                tournamentStack.axis = .vertical
                tournamentStack.alignment = .center
                tournamentStack.spacing = 8
                
                let logoImage = UIImageView()
                logoImage.contentMode = .scaleAspectFit
                logoImage.load(urlString: tournament.logoUrl)
                
                logoImage.snp.makeConstraints { make in
                    make.width.height.equalTo(48)
                }
                
                let nameLabel = UILabel()
                nameLabel.text = tournament.name
                nameLabel.font = .roboto(size: 12)
                nameLabel.textColor = .gray
                nameLabel.textAlignment = .center
                nameLabel.numberOfLines = 2
                
                tournamentStack.addArrangedSubview(logoImage)
                tournamentStack.addArrangedSubview(nameLabel)
                
                rowStack.addArrangedSubview(tournamentStack)
            }
            
            if rowTournaments.count < maxTournamentsPerRow {
                for _ in 0..<(maxTournamentsPerRow - rowTournaments.count) {
                    let emptyView = UIView()
                    rowStack.addArrangedSubview(emptyView)
                }
            }
            
            mainStack.addArrangedSubview(rowStack)
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

